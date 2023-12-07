#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Funnel/nmRec_2
file=WALKER*

#scp -r $user@$server:$dir/$file1 ./
#scp -r $user@$server:$dir/$file2 ./
scp -r $file $user@$server:$dir

