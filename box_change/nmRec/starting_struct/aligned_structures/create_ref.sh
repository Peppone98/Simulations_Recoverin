#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # obtain from tpr the reference
    gmx editconf -f md_meta_${n_walk[i]}.tpr -o reference_${n_walk[i]}.pdb

    # remove the water, which gives problems with plumed
    echo 18 | gmx trjconv -f reference_${n_walk[i]}.pdb -s md_meta_${n_walk[i]}.tpr -o ref_${n_walk[i]}.pdb
    
    # get the protein for funnel definition 
    echo 1 | gmx trjconv -f reference_${n_walk[i]}.pdb -s md_meta_${n_walk[i]}.tpr -o prot_${n_walk[i]}.pdb

    # remove the useless files
    rm reference_${n_walk[i]}.pdb
done

echo "Grommp action completed"


