#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure


user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/membr_Rec
file1=ref_nowat.gro
#file2=traj_nowat.xtc


# Copy on cluster
#scp $file $user@$server:$dir

# Copy from cluster
scp $user@$server:$dir/$file1 ./
#scp $user@$server:$dir/$file2 ./