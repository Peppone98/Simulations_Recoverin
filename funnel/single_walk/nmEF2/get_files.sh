#!/usr/bin/

user=ggambini
server=login.leonardo.cineca.it

# scp user@remote:'/path1/file1 /path2/file2 /path3/file3' /localPath

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/sw_nmEF2
file0=Funnel_metaD.dat
file1=C_alpha.pdb
file2=index.ndx
file3=Meta_funnel.tpr
file4=pocket_backbone.pdb

scp $file0 $file1 $file2 $file3 $file4 $user@$server:$dir

