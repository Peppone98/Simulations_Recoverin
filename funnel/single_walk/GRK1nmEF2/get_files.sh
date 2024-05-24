#!/usr/bin/

user=ggambini
server=login.leonardo.cineca.it

# scp user@remote:'/path1/file1 /path2/file2 /path3/file3' /localPath

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/single_walk/GRK1nmEF2
file0=Funnel_MetaD.dat
file1=C_alpha.pdb
file2=index.ndx
file3=Meta_funnel.tpr
file4=pocket_backbone_EF2.pdb
file5=GRK1_alpha.pdb

scp $file0 $file1 $file2 $file3 $file4 $file5 $user@$server:$dir

