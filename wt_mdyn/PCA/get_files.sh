#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/wall_meta/Walk_MPI/membr_Rec_mw/WALKER0
file=traj_nowat.xtc

scp $user@$server:$dir/$file ./
#scp $file $user@$server:$dir
