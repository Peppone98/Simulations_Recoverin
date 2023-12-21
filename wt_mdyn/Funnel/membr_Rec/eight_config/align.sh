#!/usr/bin/expect

# Here we build the WALKER* folders: 

n_walk=(4 5 6 7 8)

len=${#n_walk[@]}


for (( i=0; i<$len; i++ ))
do
  gmx trjconv -f ref_${n_walk[i]}.pdb -s ../md_meta.tpr -o ref_${n_walk[i]}_aligned.pdb -fit rot+trans
done