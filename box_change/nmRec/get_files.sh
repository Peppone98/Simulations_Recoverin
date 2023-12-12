#!/usr/bin/expect

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/box_change/nmRec/md
file=md_nowat.xtc

scp $user@$server:$dir/$file ./
#scp $file $user@$server:$dir
