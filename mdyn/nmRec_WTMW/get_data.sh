#!/bin/bash

# This script collects the data from the trajectories in the subfolders

n_folders=(0 1 2 3 4 5)
len=${#n_folders[@]}

# collect data
mkdir data
for (( i=0; i<$len; i++ ))
do
  cp WALKER${n_folders[i]}/COLVAR.${n_folders[i]} data
done



