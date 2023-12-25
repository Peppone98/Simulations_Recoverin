#!/usr/bin/expect

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Pilot_meta/nmRec
file=Ox_CM_Walk.dat

#scp -r $user@$server:$dir/$file ./
scp $file $user@$server:$dir
