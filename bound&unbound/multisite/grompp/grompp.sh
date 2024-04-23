#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)
n_frames=(1557 6334 1163 6716 339 6018 7737 5300)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    gmx grompp -f md.mdp -c frames/frame_${n_frames[i]}.gro -r frames/frame_${n_frames[i]}.gro -p topol.top -o tpr/md_${n_walk[i]}.tpr
done


echo "Grommp action completed"



