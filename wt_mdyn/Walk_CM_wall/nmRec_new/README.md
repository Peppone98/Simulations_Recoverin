
# Multiple walkers and CM restraint 
Here I consider the NPT equilibrated structures. The configurations should correspond to the distances `(0.05, 0.1, 0.25, 0.4, 0.55, 0.7, 0.85, 1)`. I generate the `.tpr` from them and then I adjust the `.dat` files. 

The `.gro` files are those generated from the NPT equilbration. The `tpr` files were already generated when I decided to do 1 ns of unrestrained MD. 


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

