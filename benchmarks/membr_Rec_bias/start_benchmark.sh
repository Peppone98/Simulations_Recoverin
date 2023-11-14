#!/bin/bash

# This script starts the benchmark.
# Check the numbers you used in the "build_folders.sh" script
# Execute the script from the current folder


n_cores=(20 20 32 32 32 32 36 40 48 48 50 64 64 64 64 64)
n_mpiprocs=(10 4 32 16 8 4 6 10 8 6 10 64 32 16 8 4)

len=${#n_cores[@]}

for (( i=0; i<$len; i++ ))
do
  # First we enter the folder
  cd trials/trial_${n_cores[i]}_${n_mpiprocs[i]}
  qsub md_${n_cores[i]}_${n_mpiprocs[i]}.pbs
  cd ../../
done