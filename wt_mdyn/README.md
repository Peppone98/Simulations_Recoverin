
# Folder organization
- `trials_meta`: contains single/multiple walker simulations with a wrong harmonic wall. 
- `unbiased_run_stats`: contains the statistics to determine the width of the Gaussians used in metadynamics. I took the standard deviaition of the sets of distances from the unbiased runs. 
- `Funnel`: contains the attempts of funnel metadynamics 
- `Pilot_meta`: when dealing with the multiple walker approach, it is highly suggested to start the simulations from different simulations, in order to avoid initial stresses. To sample these configurations, I started a single walker aggressive pilot metadynamics run. 
- `Walk_CM_wall`: here the wall is adjusted. I placed it at 6 A from the CM of the protein. This should allow a good sampling of the unbound state. However, simulations should be checked because the ligand may enter some other pocket. 
- `tcl_scripts`: library of tcl scripts 

## General observations 

- We expect that the run with multiple walkers will converge more quickly to the target free energy.
- An higher bias-factor $\gamma$ should lead to a more decoupled dynamics between the CV $d_1$ and the rest of the system. 

## Pay attention to the reference
I took the starting configurations for the metadynamics runs from the last frame of the trajectory without the bias (you can find it in the `tpr_generation` folder).


## Start'em up
In order to start each run, I have to provide 
1. the `.tpr` file
2. the `reference.pdb`
3. the `.dat` file with the pllumed actions 
4. a proper `.pbs` file 

Remember to modify the `.dat` and the `.pbs` for the restarting procedure. Remember also that in the case of multiple walkers you must put the `.dat`, `.pdb` and the `.tpr` files in all the folders. 

## Observation on the implementation of the walls 
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

