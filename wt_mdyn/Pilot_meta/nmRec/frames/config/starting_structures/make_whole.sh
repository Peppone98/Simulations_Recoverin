#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # Set the input trajectory file and topology file
    input_file=ref_${n_walk[i]}.gro
    tpr_file=../../md_meta.tpr

    # Always select System as output
    echo "0" | gmx trjconv -f $input_file -s $tpr_file -o ref_${n_walk[i]}_whole.gro -pbc whole
done

echo "Processing complete."


