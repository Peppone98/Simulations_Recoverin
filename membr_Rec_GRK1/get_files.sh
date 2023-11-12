#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/membr_Rec_GRK1/nvt_2
file=nvt_2.tpr

# if you want to copy on cluster
scp $file $user@$server:$dir


#if you want to copy from cluster
#scp $user@$server:$dir/$file ./