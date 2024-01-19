#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    gmx grompp -f ../mdp_struct/md_meta.mdp -c npt_gro/npt_${n_walk[i]}.gro -r npt_gro/npt_${n_walk[i]}.gro -p ../topol.top -o tpr/md_${n_walk[i]}.tpr
done

echo "Grommp action completed"


