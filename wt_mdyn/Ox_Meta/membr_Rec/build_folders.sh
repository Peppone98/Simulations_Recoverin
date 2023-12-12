#!/usr/bin/expect

# Here we build the WALKER* folders: 

n_walk=(0 1 2 3)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
  mkdir WALKER${n_walk[i]}
done

for (( i=0; i<$len; i++ ))
do
  cp Ox_Walk.dat WALKER${n_walk[i]}/
  cp md_meta.tpr WALKER${n_walk[i]}/
  cp reference.pdb WALKER${n_walk[i]}/
done
