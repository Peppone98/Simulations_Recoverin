
# Pilot single walker metadynamics 

Inside the folder `frames` I selected the frames from the biased run corresponding to significative values of the CV distance. 

I used the other files to do the simulation on the cluster. 

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

