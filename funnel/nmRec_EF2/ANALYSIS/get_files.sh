#!/usr/bin/

user=ggambini
server=login.leonardo.cineca.it

# scp user@remote:'/path1/file1 /path2/file2 /path3/file3' /localPath

dir=/leonardo_work/IscrC_Meta-Rec/giuseppe/FUNNEL/nmRec_EF2
file=data

scp -r $user@$server:$dir/$file ./

