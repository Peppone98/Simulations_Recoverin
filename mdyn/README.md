
# Definitive folder of the metadynamics runs 

This folder contains all the Well-Tempered (WT) metadynamics that are analyzed in the thesis. Together with Prof. Lattanzi, we chose to compare two types of metadynamics:
- a WT metadynamics with $\tau=1000$, $w_0=1.0$ kJ/mol, $\gamma=8$, $\sigma=0.007$ nm.
- a WT metadynamics with six multiple walkers acting on the same landscape with $\tau=400$, $w_0=1.2$ kJ/mol, $\gamma=10$, $\sigma=0.007$ nm.

We expect that the run with multiple walkers will converge more quickly to the target free energy. An higher bias-factor $\gamma$ should lead to a more decoupled dynamics between the CV $d_1$ and the rest of the system. 

## Pay attention to the reference
Be careful because the reference was obtained from the last frame of the trajectory without the bias. 

In order to restart the simulation from the "equilibrium" configuration at 20 ns, we need to create a new `md_meta.tpr` file. We want `md_meta.tpr` to be able to generate 100 ns of run. We modify the `mdp/md.mdp` file accordingly. We do this with 
```
gmx grompp -f mdp/md.mdp -c md.gro -p topol.top -o md_meta.tpr
```
Then I can copy the `reference.pdb` (even if the coordinates have moved away from their positions because this file only tells plumed the numbers associated to the atoms). 

## Start'em up
In order to start each run, I have to provide 
1. the `.tpr` file
2. the `reference.pdb`
3. the `.dat` file with the pllumed actions 
4. a proper `.pbs` file 

Remember to modify the `.dat` and the `.pbs` for the restarting procedure. Remember also that in the case of multiple walkers you must put the `.dat`, `.pdb` and the `.tpr` files in all the folders. 

# Non mirystoilated recoverin



# Non mirystoilated recoverin with GRK1
We continue to use $\sigma=0.007$ nm as the non-biased run showed no significative differences with the case of recoverin. 


# Observation on the implementation of the walls 
For the points near (or also beyond) the wall, you will get very poor sampling, therefore you will have very large statical errors. Remember that `sum_hills` only sums up the Gaussians to obtain the free energy profile. 


In case you want to use plumed on cluster, just do
```
module load gcc91
module load openmpi-3.0.0
module load BLAS
module load gsl-2.5
module load lapack-3.7.0
module load python-3.8.13 
source /home/giuseppe.gambini/usr/src/gmx_plumed.sh
```

