#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # create the folders
    mkdir WALKER${n_walk[i]}

    # copy the files 
    cp frames_center/frame_${n_walk[i]}.pdb WALKER${n_walk[i]}
    mv WALKER${n_walk[i]}/frame_${n_walk[i]}.pdb WALKER${n_walk[i]}/ref_${n_walk[i]}.pdb
    cp pdb/pocket_${n_walk[i]}.pdb WALKER${n_walk[i]}
    cp pdb/ref_CA_${n_walk[i]}.pdb WALKER${n_walk[i]}
    cp tpr/md_meta_${n_walk[i]}.tpr WALKER${n_walk[i]}
    cp dat/funnel_${n_walk[i]}.dat WALKER${n_walk[i]}

    # change the names of the plumed input and the tpr
    mv WALKER${n_walk[i]}/funnel_${n_walk[i]}.dat WALKER${n_walk[i]}/funnel.dat 
    mv WALKER${n_walk[i]}/md_meta_${n_walk[i]}.tpr WALKER${n_walk[i]}/md_meta.tpr
done

echo "Folders generated"


