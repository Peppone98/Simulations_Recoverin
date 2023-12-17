
# Multiple walkers and CM restraint

Here we start the metadynamics with the wall on the CM. Keep in mind that the average distance CM-CAL is about 1.5 nm, so I think a good choice might be 6.0 nm. A direct inspection of the system confirms this.




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

