#!/bin/bash

n_walk=(0 1 2 3)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # create the folders
    mkdir WALKER${n_walk[i]}

    # copy the files 
    cp ref.pdb WALKER${n_walk[i]}
    cp npt_ca.pdb WALKER${n_walk[i]}
    cp mdMeta.tpr WALKER${n_walk[i]}
    cp VB_MetaD.dat WALKER${n_walk[i]}
    cp index.ndx WALKER${n_walk[i]}

done

echo "Folders generated"


