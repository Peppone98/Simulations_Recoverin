#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/nmRec_GRK1_WT
file1=COLVAR
file2=HILLS

#scp $user@$server:$dir/$file1 ./
scp $user@$server:$dir/$file2 ./
