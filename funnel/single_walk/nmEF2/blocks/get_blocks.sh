#!/usr/bin/

for i in `seq 5001 500 10000`
do
 # run the python script
 python ../../do_block_fes.py rho_rbias_eq.dat 1 0.15 4.35 50 2.57 $i

 # Get the total number of lines
 total_lines=$(wc -l < "fes.$i.dat")

 # Calculate the number of lines to keep
 lines_to_keep=$((total_lines - 2))

 # Remove the last two lines and save the result to newfile
 head -n "$lines_to_keep" "fes.$i.dat" >> fes.$i.dat

 # calculate average error along the free-energy profile
 awk 'BEGIN{tot=0}{tot+=$3}END{print i,tot/NR}' i=$i fes.$i.dat
done >> err.blocks

