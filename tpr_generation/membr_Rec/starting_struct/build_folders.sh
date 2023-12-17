#!/usr/bin/expect

# Here we build the WALKER* folders: 

n_walk=(0 1 2 3)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
  mkdir sim_${n_walk[i]}
done

for (( i=0; i<$len; i++ ))
do
  cd sim_${n_walk[i]}/
  mkdir nvt
  mkdir npt
  mkdir unres
  mv ../nvt_${n_walk[i]}.tpr ./
  cp ../nvt.pbs ./
  cd ..
done