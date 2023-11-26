#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure


user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Walk_MPI/nmRec_mw
file1=data
file2=HILLS_shared

scp -r $user@$server:$dir/$file1 ./
scp $user@$server:$dir/$file2 ./

