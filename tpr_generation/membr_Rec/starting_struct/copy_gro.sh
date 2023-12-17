#!/usr/bin/expect

# expect -> waits for program output

# You have to insert many times the password, but still 
# this script speeds up the procedure

user=giuseppe.gambini
server=hpc2.unitn.it

dir=/home/giuseppe.gambini/simulations/tpr_generation/membr_Rec/starting_struct/sim_0/unres
file=md_0.gro

# if you want to copy on cluster
#scp $file $user@$server:$dir

#if you want to copy from cluster
scp $user@$server:$dir/$file ./


dir=/home/giuseppe.gambini/simulations/tpr_generation/membr_Rec/starting_struct/sim_1/unres
file=md_1.gro
scp $user@$server:$dir/$file ./


dir=/home/giuseppe.gambini/simulations/tpr_generation/membr_Rec/starting_struct/sim_2/unres
file=md_2.gro
scp $user@$server:$dir/$file ./


dir=/home/giuseppe.gambini/simulations/tpr_generation/membr_Rec/starting_struct/sim_3/unres
file=md_3.gro
scp $user@$server:$dir/$file ./
