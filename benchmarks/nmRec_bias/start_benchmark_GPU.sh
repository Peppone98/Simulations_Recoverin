#!/bin/bash

# This script starts the benchmark.
# Check the numbers you used in the "build_folders.sh" script
# Execute the script from the current folder


n_cores=(4 4 5 6 8 8 8 12 12 20 24)
n_mpiprocs=(2 1 1 1 4 2 1 6 2 2 2)

len=${#n_cores[@]}

for (( i=0; i<$len; i++ ))
do
  # First we enter the folder
  cd new_trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}
  qsub md_meta${n_cores[i]}_${n_mpiprocs[i]}.pbs
  cd ../../
done