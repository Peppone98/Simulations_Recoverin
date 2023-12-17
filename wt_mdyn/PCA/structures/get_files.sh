#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/wall_meta/Walk_MPI/membr_Rec_mw/WALKER3
file1=ref_1.gro
file2=ref_3.gro

scp $user@$server:$dir/$file1 ./
scp $user@$server:$dir/$file2 ./
#scp $file $user@$server:$dir
