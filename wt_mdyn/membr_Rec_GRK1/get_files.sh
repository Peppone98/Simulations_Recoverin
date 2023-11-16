#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/membr_Rec_GRK1
file1=md_meta.tpr
file2=reference.pdb
file3=meta.dat

scp $file1 $file2 $file3 $user@$server:$dir
#scp $user@$server:$dir/$file2 ./
