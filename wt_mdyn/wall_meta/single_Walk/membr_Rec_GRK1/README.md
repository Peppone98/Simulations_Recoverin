# Possible problem regarding the representation of the system

Most of the times the minimum protein-edge distance is set to 1 nm to prevent the violation of the minimum image convention

It is convenient to define two new groups, namely, the GRK1 peptide and the protein with the calcium ions.
```
gmx make_ndx -f md.gro -o index.ndx
```
We prompt `a 3305-3538` and `name 34 GRK1`. We also create the usual `Protein_CAL` selection. Next, we center the 

if you want to remove everything but the chain `A` on pymol, you should write 
```
remove not chain 'A'
```

```
gmx trjconv -s md_meta.tpr -f traj_comp.xtc -o traj_center.xtc -pbc mol -ur compact -center -n index.ndx
```
Now, to visualize the whole trajectory, we have to remove the ions and the water molecules from the initial gro. 
```
gmx trjconv -s md_meta.tpr -f md.gro -n index.ndx -o start.gro
```
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
To call gromacs, you have to call `gmx_mpi`. 
# Test the INTERACTIONS_VS_TIME algorithm 
```
python ../INT_VS_TIME_package/main.py -t traj_prot.xtc -s Rec.pdb -nprots 1 -nres 200 -b
```
