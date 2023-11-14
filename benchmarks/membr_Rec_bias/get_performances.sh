#!/bin/bash


touch performances.txt

n_cores=(4 4 4 6 6 8 8 8 8 12 12)
n_mpiprocs=(4 2 1 6 1 8 4 2 1 6 2)

len=${#n_cores[@]}

for (( i=0; i<$len; i++ ))
do
  grep 'Performance' trials_GPU/trial_${n_cores[i]}_${n_mpiprocs[i]}/md.log >> performances.txt
done


