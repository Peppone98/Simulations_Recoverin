
# We must create a larger box

We isolate the protein structure and the ions again. 
```
grep -v "SOL" "nmRec_GRK1_solv.pdb" > "nmRec_GRK1.pdb"
```
and then eliminate the ions by hand. 

## Terminal group patching
```
gmx pdb2gmx -f nmRec_GRK1.pdb -o nmRec_GRK1_processed.gro -ter yes
```
I put the capped hands also for the small GRK1 peptide. I did this because the option of standard capping returned an error. 

## Change the size of the box 
```
gmx editconf -f nmRec_GRK1_processed.gro -box 10 10 10 -o new_nmRec_GRK1.gro
```

## Solvation
```
gmx solvate -cp new_nmRec_GRK1.gro -cs spc216.gro -o complex_solv.gro -p topol.top
```

## Add the ions
```
gmx grompp -f mdp/ions.mdp -c complex_solv.gro -p topol.top -o ions.tpr
```
Based on our previous attempt with CHARMM-GUI, we do
```
gmx genion -s ions.tpr -o complex_solv_ions.gro -p topol.top -pname K -nname CL -conc 0.15 -neutral
```

## Energy minimization
```
gmx grompp -f mdp/em.mdp -c complex_solv_ions.gro -p topol.top -o em.tpr
```

## NVT equilibration
```
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
```

## NPT equilibration
```
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
```

## 10 ns of unrestrained dynamics 
```
gmx grompp -f mdp/md.mdp -c npt.gro -p topol.top -o md.tpr
```