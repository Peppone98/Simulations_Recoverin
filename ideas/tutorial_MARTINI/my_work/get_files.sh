#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/tutorial_MARTINI/min
file1=minimization-vac.gro
#file2=minimization-vac.tpr

#scp $file1 $user@$server:$dir
#scp $file2 $user@$server:$dir
scp $user@$server:$dir/$file1 ./
#scp $user@$server:$dir/$file2 ./
