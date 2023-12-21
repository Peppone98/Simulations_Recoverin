#!/usr/bin/expect

# Here we build the WALKER* folders: 

n_walk=(0 1 2 3)

len=${#n_cores[@]}

for (( i=0; i<$len; i++ ))
do
  mkdir WALKER${n_cores[i]}
done

for (( i=0; i<$len; i++ ))
do
  cp meta_MW.dat WALKER${n_cores[i]}/
  cp md_meta.tpr WALKER${n_cores[i]}/
  cp reference.pdb WALKER${n_cores[i]}/
done