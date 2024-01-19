#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    rm WALKER${n_walk[i]}/md_${n_walk[i]}.tpr
    cp tpr/md_${n_walk[i]}.tpr WALKER${n_walk[i]}
done

echo "Folders generated"


