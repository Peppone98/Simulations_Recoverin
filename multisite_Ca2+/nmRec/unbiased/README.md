
# Simulations with the multisite Calcium ion

We have already generated the files for the simulation with Charmm. Now, we proceed with an unbiased simulation. 

## minimization, NVT and NPT 
We move to the `gromacs` folder inside the `charmm-gui-inputs` directory and execute the following commands.  
```
gmx grompp -f mdp/em.mdp -c input.gro -p topol.top -o em.tpr
```
```
gmx grompp -f mdp/nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
```
```
gmx grompp -f mdp/npt.mdp -c nvt.gro -r nvt.gro -p topol.top -o npt.tpr
```

# production run
For the unbiased run:
```
gmx grompp -f mdp/md.mdp -c npt.gro -r npt.gro -p topol.top -o md.tpr
```

For the volume based metadynamics run: 
```
gmx grompp -f mdp/md_meta.mdp -c npt.gro -r npt.gro -p topol.top -o mdMeta.tpr
```