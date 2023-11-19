
# Unbiased simulation

This brief simulation (about 20-40 ns) is meant to provide a first estimate of the standard deviation $\sigma$, which is then employed in the metadynamics scheme. We start from a given `.gro file`. We don't have to extract of the protein and the ions with VMD or pyMol because gromacs can directly treat all the ions and solvent provided that a good force field for them is provided. We download the force field `CHARMM36-feb2021` (in the `.ff` folder). 

Extra: in case you wanted to rename the residues 1-16 of the GRK1 with 203-218, you can produce the "adjusted" `.gro` file: 
```
touch nmRec_GRK1_adj.gro
sed -e 's/  1M/203M/' -e 's/  2A/204A/' -e 's/  3P/205P/' -e 's/  4G/206G/' -e 's/  5S/207S/' -e 's/  6L/208L/' -e 's/  7GLU/209GLU/' -e 's/  8T/210T/' -e 's/  9V/211V/' -e 's/ 10V/212V/' -e 's/ 11A/213A/' -e 's/ 12A/214A/' -e 's/ 13S/215S/' -e 's/ 14A/216A/' -e 's/ 15P/217P/' -e 's/ 16I/218I/' nmRec_GRK1_start.gro > nmRec_GRK1_adj.gro
```

## Generation of the `.itp` files
We need to convert the names of the ions `K` and `CL` in the names employed in the `merged.rtp` file of the force field, namely, `POT` and `SOD`. We do this with the `sed` command:
```
touch nmRec_GRK1.gro
sed -e 's/K  /POT/' -e 's/CL /CLA/' -e 's/ CL/CLA/' -e 's/  K/POT/' nmRec_GRK1_start.gro > nmRec_GRK1.gro
```
For me it's better to create another file, so that I can restart if something goes wrong. 

Your `.gro` file has a missing hydrogen in the N-terminus. Gromacs automatically adds the group `NH3+`, but in this way it spoils all the indices of the rest of the chain. In poor words, gromacs looks at the `topol_protein.itp` file and sees that the first residue has the `NH3+`. Then he complains about the mismatch of indices of the rest of the atoms. This problem can be fixed with the help of the flag `-ter yes` (by default it is set to `no`). Then `pdb2gmx` will ask you the termini you want. 

This time we also have the first 16 amino acids of the peptide GRK1. Let's open the file `nmRec_GRK1_start.gro` in pyMol. We select `Display->Sequence`. You can also change the representation of the residues by doing `Display->Sequence Mode->Residue Name`. After having done the selection of the residues from 203 to 218
```
select atoms, id 3264-3497
alter (atoms),chain="GRK1"
```
we save the `.pdb` file with `Export Molecule` and `Retain Atom id`. We can then proceed with `pdb2gmx`. 


```
gmx pdb2gmx -f nmRec_GRK1.pdb -o nmRec_ions_solv_GRK1.gro -ter yes
```
NOTE: this time gromacs will ask you to specify also the termini of the GRK1 peptide! 

## Energy minimization
```
gmx grompp -f mdp/em.mdp -c nmRec_ions_solv_GRK1.gro -p topol.top -o em.tpr
```
Then you can send the `.tpr` on the cluster:
```
scp em.tpr giuseppe.gambini@hpc2.unitn.it:/home/giuseppe.gambini/simulations/nmRec_Ca_GRK1
```

## NVT equilibration 
First we download the `.gro` file from the cluster:
```
scp giuseppe.gambini@hpc2.unitn.it:/home/giuseppe.gambini/simulations/nmRec_Ca_GRK1/em.gro ./
```

Important: we need to use dispersion correction if the force field was parametrized to use it. Dispersion correction is not used for proteins with the C36 additive FF. I basically used the `.mdp` files reported in the tutorial of JZ4. Then I modified the temperature to 310 K.
```
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
```
With 24 logical cores and 24 mpi processes, the performance is again 33.471 ns/day.

## NPT equilibration
This time we can optionally copy the `.cpt` file containing the "checkpoint" of the trajectory, but the version of gromacs 2021.4 will return the message `Attempting to read a checkpoint file of version 23 with code of version 22`. The `.cpt` file only contains information about the velocity, but there is nothing wrong about restarting the simulation with another set of velocities since we are still doing an equilibration. The information on the last frame is already contained in `nvt.gro`. 
```
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
```
The performance is still relatively low: 35.631 ns/day for 32 cores, 8 MPI processes and 4 OpenMPI threads.

## MD production run
We produce a run of 20 ns (it can be further expanded). Remember to modify the `.mdp` file properly, checking the simulation time and the temperature. 
```
gmx grompp -f mdp/md.mdp -c npt.gro -p topol.top -o md.tpr
```
Before launching our simulation, we perform a small benchmark (see the `benchmarks` folder). 
