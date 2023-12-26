#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    gmx editconf -f tpr/md_meta_${n_walk[i]}.tpr -o pdb/reference_${n_walk[i]}.pdb
    echo 18 | gmx trjconv -f pdb/reference_${n_walk[i]}.pdb -s tpr/md_meta_${n_walk[i]}.tpr -o pdb/ref_${n_walk[i]}.pdb
    echo 1 | gmx trjconv -f pdb/reference_${n_walk[i]}.pdb -s tpr/md_meta_${n_walk[i]}.tpr -o pdb/prot_${n_walk[i]}.pdb
    rm pdb/reference_${n_walk[i]}.pdb
done

echo "Grommp action completed"


