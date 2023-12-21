#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/
#dir1=membr_Rec_mw
#dir2=membr_Rec_GRK1_mw
file=start_sim.sh

#scp $user@$server:$dir/$file1 ./
#scp $user@$server:$dir/$file2 ./
scp $file $user@$server:$dir
#scp -r $dir2 $user@$server:$dir
