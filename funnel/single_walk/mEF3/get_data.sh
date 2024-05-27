#!/usr/bin/

user=ggambini
server=login.leonardo.cineca.it

# scp user@remote:'/path1/file1 /path2/file2 /path3/file3' /localPath

rm -r data
mkdir data

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/mEF3
file0=metad_data.dat
file1=gyration.dat
file2=Ca_EF3_funnel.dat
file3=BIAS
file4=all_coordination_45.dat
file5=rmsd.dat
file6=walls.dat
file7=HILLS

scp $user@$server:$dir/$file0 $user@$server:$dir/$file1 $user@$server:$dir/$file2 $user@$server:$dir/$file3 $user@$server:$dir/$file4 $user@$server:$dir/$file5 $user@$server:$dir/$file6 $user@$server:$dir/$file7 data

