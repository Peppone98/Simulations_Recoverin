
# Funnel metadynamics 

This folder contains the analysis of a new simulation in which the radius of the cylinder was increased. This should allow an easier sampling of the unbound state of the calcium ion. 


This idea comes from a fruitful conversation with Alessio :)

The problem is that the $\text{Ca}^{2+}$ ion does not completely detach from the protein during the simulations. Instead, it interacts with other residues outside the pocket and never leaves the protein. This effect is due to the wall I implemented at 1.3 nm. This prevents $\text{Ca}^{2+}$ from detaching.


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

# Funnel metadynamics
We have to introduce the funnel restraint of the system under study, which is done with the graphical user interface implemented in VMD. 

The funnel restraint should should be placed on the system so as to include the ligand binding site in the cone section of the funnel. 

- The points A and B represent the extremes of the funnel cone.
- `Zcc` defines the switching point between the cone and the cylindric section of the funnel. 
- `alpha` defines the amplitude of the conic region, in radians. 
- `Rcyl` is the radius of the cylindric section. 

The funnel volume in orange represents the space that will be sampled by the center of mass of the ligand. The script `ffs.tcl` is a post-processing script. To open the graphical interface, type `ffs_tk`. 


# Eight starting configurations
I take the configurations from the NPT runs I made starting from configurations sampled from the pilot metadynamics of nmRec. 


