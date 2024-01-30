#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    gmx grompp -f mdp/md_meta.mdp -c frames_center/frame_${n_walk[i]}.pdb -r frames_center/frame_${n_walk[i]}.pdb -p topol.top -o tpr/md_meta_${n_walk[i]}.tpr
done


echo "Grommp action completed"

# gmx editconf -f tpr/md_meta_${n_walk[i]}.tpr -o pdb/reference_${n_walk[i]}.pdb


