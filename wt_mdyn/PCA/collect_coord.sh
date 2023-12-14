#!/usr/bin/expect

# Here we build the WALKER* folders: 

n_walk=(0 1 2 3)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
  cd WALKER${n_walk[i]}
  mv COORD COORD_${n_walk[i]}
  cp COORD_${n_walk[i]} ../coord
  cd ..
done