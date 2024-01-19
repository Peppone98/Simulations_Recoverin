#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    mkdir WALKER${n_walk[i]}

    gmx editconf -f tpr/md_${n_walk[i]}.tpr -o pdb/ref_${n_walk[i]}.pdb
    cp pdb/ref_${n_walk[i]}.pdb WALKER${n_walk[i]}
    cp tpr/md_${n_walk[i]}.tpr WALKER${n_walk[i]}
    cp dat/CM_Walk.dat WALKER${n_walk[i]}
done

echo "Folders generated"


