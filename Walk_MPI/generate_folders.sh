#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    mkdir WALKER${n_walk[i]}

    cp ref.pdb WALKER${n_walk[i]}
    cp md_Meta.tpr WALKER${n_walk[i]}
    cp Walkers.dat WALKER${n_walk[i]}
done

echo "Folders generated"


