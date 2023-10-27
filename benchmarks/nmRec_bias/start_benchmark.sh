#!/bin/bash

# This script starts the benchmark.
# Check the numbers you used in the "build_folders.sh" script
# Execute the script from the current folder


n_cores=(20 20 24 24 24 24 32 32 32 36 36 40 40 48 48 48 48 50 64 64 64 64 72 72)
n_mpiprocs=(10 4 24 12 6 4 16 8 4 18 6 20 10 24 12 8 6 10 32 16 8 4 36 18)

len=${#n_cores[@]}

for (( i=0; i<$len; i++ ))
do
  # First we enter the folder
  cd trials_CPU/trial_${n_cores[i]}_${n_mpiprocs[i]}
  qsub md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  cd ../../
  cd trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}
  qsub md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  cd ../../
done