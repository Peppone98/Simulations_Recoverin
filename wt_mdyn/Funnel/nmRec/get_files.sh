#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/tpr_generation/nmRec/md
file=md_nowat_fit.xtc

#scp $file1 $user@$server:$dir
#scp $user@$server:$dir/$file1 ./
scp $user@$server:$dir/$file ./
