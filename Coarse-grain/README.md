
# Coarse graining of the nmRec 

First of all, we isolate the protein in `nmRec.pdb`. We have to extract the secondary structure, which has to be fed to Martinize2. To do this, we use the online tool http://bioinformatica.isa.cnr.it/SUSAN/DSSP-web/, copy the `.pdb` file and then wait for the output sequence. 

Unfortunately, the tool seems to skip the last residue. I add a `c` in the sequence (as the tool did for the last three residues). 

We proceed with 

```
martinize2 -f nmRec.pdb -o nmRec.top -x nmRec_cg.pdb -ss ccTTcScccSSTTTSGGGcScScHHHHHHHHHHHHHHSGGGcBcHHHHHHHHHHHSTTcccHHHHHHHHHHHcSSSSSSBcHHHHHHHHHHHccSSSSccHHHHHHHHcSScSScBcHHHHHHHHHHHHHHScHHHHHTSSTTccSHHHHHHHHHHHTTccTTccBcHHHHHHHHHHcHHHHHHHcccHHHHHHHHHcccc -p backbone -ff martini3001
```

Now I manually edit the `.top` file in order to include the two structural Calcium ions. From now on, look at the `system.top` file. To avoid unwanted errors of numeration, I labelled the two `CA` residues as residues 202 and 203. The CG coordinates are saved in `system_cg.pdb`.

Importantly, if you want to rename the ugly `molecule_0.itp`, then you must also modify the file itself after `[ moleculetype ]`. Then of course you have to modify the topology file accordingly. 

# Short minimization in vacuum 
First, we define the simulation box 
```
gmx editconf -f system_cg.pdb -box 10 10 10 -o system_cg.gro
```
In the `minimization.mdp` file we leave 10 kJ/mol (the default value for `emtol` in gromacs). Remember to correct the `system.top` with the name of the `martini.itp` you are using. 

```
gmx grompp -p system.top -f minimization.mdp -c system_cg.gro -o min_vacuum.tpr -r system_cg.gro
```
```
gmx mdrun -deffnm min_vacuum -v
```

# Solvate the system
Gromacs needs to know the van der Waals radii of each atom, namely, the radius of an imaginary hard sphere representing the distance of closest approach for another atom. Think at the van der Waals equation of state: there you have terms accounting for the efective volume occupied by the atoms. For instance, the $r_{\text{vdw}}$ of Carbon is 0.17 nm. Since we are introducing new atoms with respect to the ones listed in the default file `vdwradii.dat` of gromacs, we have to specify a global vdw radius. 
```
gmx solvate -cp min_vacuum.gro -cs water.gro -radius 0.21 -o system_solv.gro
```
The value 0.21 typically avoids clashes because gromacs will then fill the space available to water by trying to be gentle with the distances between beads (of both water and protein). In fact, if two beads are generated too close, this situation may correspond to an overlap in the AA system, which is clearly unwanted.

The option `-cs` specifies the solvent. More specifically, `solvate` assumes you are passing a box of pre-equilibrated solvent. This is given in the `water.gro` file. If you think about it, this operation is not strange, since the usual `spc216.gro` is actually a pre-equilibrated structure containing water molecules. Most probably, gromacs deduces a RDF and an average bulk density from this file and replicates them in the actual box containing the protein. Remember that each Martini water bead represents 4 water molecules.

The density of the whole system returned by gromacs is 2331.11 (g/l).


# Adding the ions
You first need to update the topology to reflect the added water (`W        7575`). And then you must also add the topology file of the solvent (all these operations aren't done automatically as in groamcs).
```
gmx grompp -f minimization.mdp -c system_solv.gro -p system.top -o ions.tpr
```
```
gmx genion -s ions.tpr -o solv_ions.gro -p system.top -pname NA -nname CL -conc 0.15 -neutral
```
The potassium ion is not present in the Martini force field for ions, so I used sodium. Long range electrostatic interactions are absent, and for small ions the first hydration shell is considered an implicit part of the CG ion. 

## Minimization in solution
The only difference is that here we do not have the protein in vacuum anymore, but the whole system. 
```
gmx grompp -p system.top -c solv_ions.gro -f minimization.mdp -o min_solution.tpr -r solv_ions.gro
```
```
gmx mdrun -deffnm min_solution -v
```

# Equilibration run: NPT
Most simulations are numerically stable with dt=40 fs. Remember to include the line `define = -DPOSRES` in the `.mdp` file. The Martinize2 script already inserted the restraints on the backbone atoms in `nmRec.itp`. You may also need to use `refcoord_scaling = com`. 
```
gmx grompp -p system.top -c min_solution.gro -f equilibration.mdp -o equilibration.tpr -r min_solution.gro
```
```
gmx mdrun -deffnm equilibration -v
```

# Production run
```
gmx grompp -p system.top -c equilibration.gro -f dynamic.mdp -o dynamic.tpr 
```

# Visualization of the trajectory in VMD
```
gmx trjconv -f equilibration.gro -s dynamic.tpr -conect -o equilibration.pdb -pbc whole
```
Then, remember to cancel the line containing `ENDMDL` in the pdb file. 


## Small note on PME
Using Particle Mesh Ewald (PME) in a coarse-grained Martini simulation is generally not recommended. PME is a method commonly employed in molecular dynamics simulations to handle long-range electrostatic interactions in systems with detailed atomic representations. However, the Martini force field is specifically designed for coarse-grained simulations, where multiple atoms are represented by a single interaction site or bead. In Martini simulations, electrostatic interactions are usually treated with a simple Coulombic potential that does not require the use of PME. 


