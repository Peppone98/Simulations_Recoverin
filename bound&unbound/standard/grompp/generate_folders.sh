#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # create the folders
    mkdir SIM${n_walk[i]}

    # copy the files 
    cp tpr/md_${n_walk[i]}.tpr SIM${n_walk[i]}
    cp get_data.dat SIM${n_walk[i]}
    cp index.ndx SIM${n_walk[i]}

    # change the names of the plumed input and the tpr 
    mv SIM${n_walk[i]}/md_${n_walk[i]}.tpr SIM${n_walk[i]}/md.tpr
done

echo "Folders generated"


