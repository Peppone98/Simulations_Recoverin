#!/bin/bash

# This script collects the data from the trajectories in the subfolders

n_folders=(0 1 2 3 4 5)
len=${#n_folders[@]}

# Execute plumed driver inside each folder
for (( i=0; i<$len; i++ ))
do
  # First we enter the folder
  cd WALKER${n_folders[i]}
  plumed driver --../plumed get_d_Calpha.dat --mf_xtc traj_comp.xtc
  cd ../
done

# collect data
mkdir data
for (( i=0; i<$len; i++ ))
do
  # First we enter the folder
  cp WALKER${n_folders[i]}/D2_CA data
  mv D2_CA D2_CA${n_folders[i]}
done



