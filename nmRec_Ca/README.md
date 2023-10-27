
# Unbiased simulation

This brief simulation (about 20-40 ns) is meant to provide a first estimate of the standard deviation $\sigma$, which is then employed in the metadynamics scheme. We start from a given `.gro file`. We don't have to extract of the protein and the ions with VMD or pyMol because gromacs can directly treat all the ions and solvent provided that a good force field for them is provided. We download the force field `CHARMM36-feb2021` (in the `.ff` folder). 

## Generation of the `.itp` files
We brutally take the input `.gro` file and create the `.top` and the `.itp` files. But first, we need to convert the names of the ions `K` and `CL` in the names employed in the `merged.rtp` file of the force field, namely, `POT` and `SOD`. We do this with the `sed` command:
```
touch nmRec.gro
sed -e 's/K  /POT/' -e 's/CL /CLA/' -e 's/ CL/CLA/' -e 's/  K/POT/' nmRec_start.gro > nmRec.gro
```
For me it's better to create another file, so that I can restart if something goes wrong. 

Important: your `.gro` file has a missing hydrogen in the N-terminus. Gromacs automatically adds the group `NH3+`, but in this way it spoils all the indices of the rest of the chain. In poor words, gromacs looks at the `topol_protein.itp` file and sees that the first residue has the `NH3+`. Then he complains about the mismatch of indices of the rest of the atoms. This problem can be fixed with the help of the flag `-ter yes` (by default it is set to `no`). Then `pdb2gmx` will ask you the terminii do you want. 

```
gmx pdb2gmx -f nmRec.gro -o nmRec_ions_solv.gro -ter yes
```

I selected `GLY-NH2` as the start terminus and `COOH` for the ending terminus of `Leu-202`. The command `pdb2gmx` generates also `topol_Other2.itp` for the Potassium, Clorine and Magnesium ions.

## Energy minimization
```
gmx grompp -f mdp/em.mdp -c nmRec_ions_solv.gro -p topol.top -o em.tpr
```
Then you can send the `.tpr` on the cluster:
```
scp em.tpr giuseppe.gambini@hpc2.unitn.it:/home/giuseppe.gambini/simulations/nmRec_Ca
```

## NVT equilibration 
First we download the `.gro` file from the cluster:
```
scp giuseppe.gambini@hpc2.unitn.it:/home/giuseppe.gambini/simulations/nmRec_Ca/em.gro ./
```

Important: we need to use dispersion correction if the force field was parametrized to use it. Dispersion correction is not used for proteins with the C36 additive FF. I basically used the `.mdp` files reported in the tutorial of JZ4. Then I modified the temperature to 310 K.
```
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
```
The performance here is about 33.107 ns/day.

## NPT equilibration
```
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
```
The performance for 36 cores, 6 MPI processes and 6 OpenMPI threads is much better, about 60.588 ns/day !

## MD production run
We produce a run of 20 ns (it can be further expanded). The idea is to use the exiting structure `.gro` as the first frame of each metadynamics. Before launching our simulation, we perform a small benchmark (see the `benchmarks` folder).  
```
gmx grompp -f mdp/md.mdp -c npt.gro -p topol.top -o md.tpr
```
PLEASE, BE CAREFUL: when you restart the simulation you have to use the last checkpoint `md.cpt` and not the previous checkpoint `md_prev.cpt` ! 
