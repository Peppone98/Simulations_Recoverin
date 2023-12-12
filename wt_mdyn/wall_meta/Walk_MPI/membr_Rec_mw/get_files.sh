#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure


user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/mdyn/Walk_MPI/membr_Rec_mw
file1=HILLS_shared
file2=data


# Copy on cluster
#scp $file $user@$server:$dir

# Copy from cluster
scp $user@$server:$dir/$file1 ./
scp -r $user@$server:$dir/$file2 ./