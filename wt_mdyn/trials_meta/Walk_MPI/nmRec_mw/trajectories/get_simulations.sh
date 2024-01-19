#!/usr/bin/expect

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Walk_MPI/nmRec_mw
file1=
file2=COLVAR

n_folders=(0 1 2 3 4)

len=${#n_folders[@]}

for (( i=0; i<$len; i++ ))
do
    file=WALKER${n_folders[i]}/traj_nowat_${n_folders[i]}.xtc
    scp $user@$server:$dir/$file ./
done

