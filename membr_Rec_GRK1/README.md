
# Myristoylated Recoverin in membrane in complex with GRK1

The folder `charmm36-feb2021_vm.ff` contains the force field with the parameters of the myristoylated glicine at the N-terminal. The `residuetypes.dat` contains the definition of `GLM` (N-myristoyl Gly) as a protein residue. 

When using `pdb2gmx` we need to use the option `-ter` for the "capping" of the N and C-terminals. This time we need to select `none` for the N-terminal. 


![Alt text](Rec_with_myristoyl.png)
*A picture of the system membrane + protein. Notice the myristoyl group inside the membrane.*


## Generation of the `.itp` files 

Now we brutally take the input `.gro` file and create the `.top` and the `.itp` files. 
```
gmx pdb2gmx -f membr_Rec_GRK1_start.gro -o membr_Rec_GRK1_ions_solv.gro -ter yes
```
and we have to select `none` when we're asked about capping the first residue and `COOH` for the ending terminus of `Leu-202`. This operation takes approximately 15 minutes on local. 

Let's open the file `nmRec_GRK1_start.gro` in pyMol. We select `Display->Sequence`. You can also change the representation of the residues by doing `Display->Sequence Mode->Residue Name`. After having done the selection of the residues from 203 to 218
```
select atoms, id 3264-3497
alter (atoms),chain="GRK1"
```
we save the `.pdb` file with `Export Molecule` and `Retain Atom id`. We can then proceed with `pdb2gmx`. 

```
gmx pdb2gmx -f nmRec_GRK1.pdb -o nmRec_ions_solv_GRK1.gro -ter yes
```
NOTE: this time gromacs will ask you to specify also the termini of the GRK1 peptide! 


Here we have another peptide in solution, namely, GRK1. We must treat carefully also its termini. 

## Observations about the `.mdp` files in presence of a membrane
The most important parameter for pressure coupling in membrane is `pcoupltype = semiisotropic`. This means that the pressure coupling is not completely isotropic, rather we impose an uniform scaling of x-y box vectors, while the z component is independent. We deal with a squared membrane, so we don’t want to obtain a rectangular one at the end of our setup.


Remember that the internal pressure is maintained constant by allowing the volume of the simulation box to fluctuate. 

In most simulations of membranes the pressure coupling is limited to the z component, thus keeping fixed the x-y shape of the system.

`nose-hoover`: temperature coupling using a Nose-Hoover extended ensemble. in this case tau-t controls the period of the temperature fluctuations at equilibrium, which is slightly different from a relaxation time. For NVT simulations the conserved energy quantity is written to the energy and log files.
`tau-t`: time constant for coupling, (one for each group in `tc-grps`).
`nsttcouple`: the frequency for coupling the temperature. The default value of -1 sets nsttcouple equal to 100, or fewer steps if required for accurate integration (5 steps per tau for first order coupling, 20 steps per `tau` for second order coupling).

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