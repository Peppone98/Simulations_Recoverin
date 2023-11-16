#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir1=Adaptive_Geom
dir2=Multi_Walkers
dir_cl=/home/giuseppe.gambini/simulations/WTMdyn/nmRec

scp -r $dir1 $user@$server:$dir_cl
#scp -r $dir2 $user@$server:$dir_cl


