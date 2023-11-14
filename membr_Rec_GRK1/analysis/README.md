
# Prepare the reference for plumed

We want to perform the same analysis performed on the recoverin alone. 

In this case, we also have the rhodopsin kinase (GRK1), which is inhibited by the calcium-binding protein recoverin. 

Be careful because the number associated to each atom may change. We remind that the group of atoms we need to keep track of is `ASP74 OD2`, `ASN76 OD1`, `ASP78 OD2`, `THR80 O`, `GLU85 OE1`, `GLU85 OE2` (I checked that the atoms are the same). 

## Get the reference structure for the `MOLINFO` commmand
```
gmx editconf -f md.tpr -o reference.pdb
```
If you used straight up the `md.tpr` file of the Rec with GRK1, plumed will return an error and prompt the message 
```
pdb file named reference.pdb contains 5 chains 
```
The solution is to name the unnamed chain containing the two calcium ions. 

# The numbers of the atoms have changed
We have a mismatch equal to 41 atom positions due to the myristoyl termination. Check the `.dat` files.

# CRITICAL! PLUMED DOES NOT SUPPORT `.pdb` FILES WITH n_atoms > 100000
Yes, but we are not doomed. We can erase all the `SOL` molecules from the file and then try again. 
```
awk '!/SOL/' reference.pdb > temp && mv temp reference.pdb
```


## Start the analysis with plumed 
```
plumed driver --plumed get_distance.dat --mf_xtc md.xtc
```
## Get the stats from gnuplot
```
gnuplot >> stats "DIST" u 2
```
Again, we obtain a very similar $\sigma=0.0066$ nm. 


In case you want to use plumed on cluster, just do
```
module load gcc91
module load openmpi-3.0.0
module load BLAS
module load gsl-2.5
module load lapack-3.7.0
module load python-3.8.13 
source /home/giuseppe.gambini/usr/src/gmx_plumed.sh
```