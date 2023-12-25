#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    gmx grompp -f ../../mdp_struct/md_meta.mdp -c md_${n_walk[i]}_aligned.gro -r md_${n_walk[i]}_aligned.gro -p ../../topol.top -o md_meta_${n_walk[i]}.tpr
done

echo "Grommp action completed"


