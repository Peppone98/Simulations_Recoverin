#!/usr/bin/expect

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/CM_Meta/membr_Rec
file=WALKER

#scp $user@$server:$dir/$file ./
scp -r $file* $user@$server:$dir
