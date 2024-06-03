#!/usr/bin/

user=ggambini
server=login.leonardo.cineca.it

# scp user@remote:'/path1/file1 /path2/file2 /path3/file3' /localPath

################### mEF3 folder ####################
rm -r mEF3/data
mkdir mEF3/data

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/mEF3
file0=BIAS
file1=gyration.dat
file2=rmsd.dat
file3=metad_data.dat
file4=all_coordination_45.dat
file5=Ca_EF3_funnel.dat
file6=walls.dat
file7=HILLS

scp $user@$server:$dir/$file0 $user@$server:$dir/$file1 $user@$server:$dir/$file2 $user@$server:$dir/$file3 $user@$server:$dir/$file4 $user@$server:$dir/$file5 $user@$server:$dir/$file6 $user@$server:$dir/$file7 mEF3/data


################### mEF2 folder ####################

rm -r mEF2/data
mkdir mEF2/data

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/mEF2
file0=BIAS
file1=gyration.dat
file2=rmsd.dat
file3=metad_data.dat
file4=all_coordination_45.dat
file5=Ca_EF2_funnel.dat
file6=walls.dat
file7=HILLS

scp $user@$server:$dir/$file0 $user@$server:$dir/$file1 $user@$server:$dir/$file2 $user@$server:$dir/$file3 $user@$server:$dir/$file4 $user@$server:$dir/$file5 $user@$server:$dir/$file6 $user@$server:$dir/$file7 mEF2/data



################### nmEF3 folder ####################

rm -r nmEF3/data
mkdir nmEF3/data

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/nmEF3
file0=BIAS
file1=gyration.dat
file2=rmsd.dat
file3=metad_data.dat
file4=all_coordination_45.dat
file5=Ca_EF3_funnel.dat
file6=walls.dat
file7=HILLS

scp $user@$server:$dir/$file0 $user@$server:$dir/$file1 $user@$server:$dir/$file2 $user@$server:$dir/$file3 $user@$server:$dir/$file4 $user@$server:$dir/$file5 $user@$server:$dir/$file6 $user@$server:$dir/$file7 nmEF3/data


################### nmEF2 folder ####################

rm -r nmEF2/data
mkdir nmEF2/data

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/nmEF2
file0=BIAS
file1=gyration.dat
file2=rmsd.dat
file3=metad_data.dat
file4=all_coordination_45.dat
file5=Ca_EF2_funnel.dat
file6=walls.dat
file7=HILLS

scp $user@$server:$dir/$file0 $user@$server:$dir/$file1 $user@$server:$dir/$file2 $user@$server:$dir/$file3 $user@$server:$dir/$file4 $user@$server:$dir/$file5 $user@$server:$dir/$file6 $user@$server:$dir/$file7 nmEF2/data
