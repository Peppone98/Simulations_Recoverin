#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # create the folders
    mkdir WALKER${n_walk[i]}

    # copy the files 
    cp pocket_backbone.pdb WALKER${n_walk[i]}
    cp C_alpha.pdb WALKER${n_walk[i]}
    cp index.ndx WALKER${n_walk[i]}
    cp Meta_funnel.tpr WALKER${n_walk[i]}
    cp Funnel_MetaD.dat WALKER${n_walk[i]}

done

echo "Folders generated"


