
# Myristoylated Recoverin in membrane in complex with GRK1

The folder `charmm36-feb2021_vm.ff` contains the force field with the parameters of the myristoylated glicine at the N-terminal. The `residuetypes.dat` contains the definition of `GLM` (N-myristoyl Gly) as a protein residue. 

When using `pdb2gmx` we need to use the option `-ter` for the "capping" of the N and C-terminals. This time we need to select `none` for the N-terminal. 


![Alt text](Rec_with_myristoyl.png)
*A picture of the system membrane + protein. Notice the myristoyl group inside the membrane.*


## Generation of the `.itp` files 
Let's open the file `nmRec_GRK1_start.gro` in pyMol. We select `Display->Sequence`. You can also change the representation of the residues by doing `Display->Sequence Mode->Residue Name`. After having done the selection of the residues of the GRK1
```
select atoms, id 3305-3538
alter (atoms),chain="G"
```
and the lipid membrane
```
select atoms, id 3539-41238
alter (atoms),chain="M"
```
we save the `.pdb` file with `Export Molecule` and `Retain Atom id`. We can then proceed with `pdb2gmx`. Next, we move on to the generation of the topology:
```
gmx pdb2gmx -f membr_Rec_GRK1.pdb -o membr_Rec_GRK1.gro -ter yes
```
NOTE: this time gromacs will ask you to specify also the termini of the GRK1 peptide! 

Here we have another peptide in solution, namely, GRK1. We must treat carefully also its termini. 

Next, we proceed as before
```
gmx grompp -f mdp/em.mdp -c membr_Rec_GRK1.gro -p topol.top -o em.tpr
```


## NVT equilibration 
We want to release progressively the restraints on membrane, protein and solvent. We can modify the `posre*.itp` files by replacing 1000 with `POSRES_PROT`, `POSRES_IONS`, `POSRES_MEMBR`, `POSRES_SOLV`.
```
sed -e 's/1000/POSRES_IONS/' -e 's/1000/POSRES_IONS/' -e 's/1000/POSRES_IONS/' posre_Ion2.itp > new_posre_Ion2.itp
```
```
sed -e 's/1000/POSRES_PROT/' -e 's/1000/POSRES_PROT/' -e 's/1000/POSRES_PROT/' posre_Protein.itp > new_posre_Protein.itp
```
```
sed -e 's/1000/POSRES_PROT/' -e 's/1000/POSRES_PROT/' -e 's/1000/POSRES_PROT/' posre_Protein_chain_G.itp > new_posre_Protein_chain_G.itp
```
```
sed -e 's/1000/POSRES_IONS/' -e 's/1000/POSRES_IONS/' -e 's/1000/POSRES_IONS/' posre_Ion3.itp > new_posre_Ion3.itp
```
```
sed -e 's/1000/POSRES_MEMBR/' -e 's/1000/POSRES_MEMBR/' -e 's/1000/POSRES_MEMBR/' posre_Other_chain_M.itp > new_posre_Other_chain_M.itp
```

Be careful: if the atom has index 1000, then you must correct that line. 

Now, you have to modify accordingly each topology file by telling gromacs to watch the new files. Moreover, you must also remember the restraint on the water molecules, directly in the principal `topol.top` file.

Now we can go on with 
```
gmx grompp -f mdp/nvt_1.mdp -c em.gro -r em.gro -p topol.top -o nvt_1.tpr
```
Remember to include the important line 
```
define = -DPOSRES  -DPOSRES_PROT=1000 
```
in the `.mdp` file (why these start with `-D` is because it mimics the command line argument for the C preprocessor).

# Equilibration runs
1.  200 ps of NVT with 1000 kJ/mol as restraint on the heavy atoms of the protein 
2. 400 ps of NPT with 1000 kJ/mol
3. 400 ps of NPT with 500 kJ/mol

I think that 1 ns of equilibration could be enough. 



## MD production run
We produce a run of 20 ns (it can be further expanded). The idea is to use the exiting structure `.gro` as the first frame of each metadynamics. Before launching our simulation, we perform a small benchmark (see the `benchmarks` folder).  
```
gmx grompp -f mdp/md.mdp -c npt.gro -p topol.top -o md.tpr
```
PLEASE, BE CAREFUL: when you restart the simulation you have to use the last checkpoint `md.cpt` and not the previous checkpoint `md_prev.cpt` !