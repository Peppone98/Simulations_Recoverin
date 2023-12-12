
# We must create a larger box

We take the more equilibrated structure of the last frame (always labeled with capital letters) of the unbiased run. We make an index file with the protein and calcium ion
```
gmx make_ndx -f NMREC.gro -o index.ndx 
```
Next, we create a pdb containing only the protein and the calcium ions: 
```
gmx trjconv -f NMREC.gro -n index.ndx -s md_meta.tpr -o nmRec.pdb
```
We can't use the solution builder tool in CHARMM-GUI because it doesn't recognize the cappings of the terminals, which might be important. So, we must use gromacs again. 

## Terminal group patching
```
gmx pdb2gmx -f nmRec.pdb -o nmRec_processed.gro -ter yes
```

## Solvation
```
gmx solvate -cp nmRec_processed.gro -cs spc216.gro -o nmRec_solv.gro -p topol.top
```

## Add the ions
```
gmx grompp -f mdp/ions.mdp -c nmRec_solv.gro -p topol.top -o ions.tpr
```
Based on our previous attempt with CHARMM-GUI, we do
```
gmx genion -s ions.tpr -o nmRec_solv_ions.gro -p topol.top -pname K -nname CL -conc 0.15 -neutral
```

## Energy minimization
```
gmx grompp -f mdp/em.mdp -c nmRec_solv_ions.gro -p topol.top -o em.tpr
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