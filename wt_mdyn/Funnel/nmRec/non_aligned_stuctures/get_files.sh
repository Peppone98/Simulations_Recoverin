#!/usr/bin/expect

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Funnel/nmRec_MW
file=WALKER*

#scp -r $user@$server:$dir/$file ./
scp -r $file* $user@$server:$dir
