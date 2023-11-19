# Structural analysis of the trajectory

The `md.gro` file represents the first frame of the trajectory. 

We have 217 protein residues: 201 are from the Recovering and the remaining 16 belong to the GRK1. I make a new index file with 
```
gmx make_ndx -f md.gro -o index.ndx
```
Then I select `1 | 13` and generate the index `Protein_CAL`. 

The option `-pbc` sets the type of periodic boundary condition treatment. The specification `nojump` checks if atoms jump across the box and then puts them back. This has the effect that all molecules will remain whole (provided they were whole in the initial conformation). Note that this ensures a continuous trajectory but molecules may diffuse out of the box. The option `-center` centers the system in the box. 
```
gmx trjconv -s new_md_meta.tpr -f traj_comp.xtc -o traj_center.xtc -pbc nojump -center
```
Unfortunately, to avoid mismatching between the provided `.xtc` and `.tpr` files, we have to save all the system to output at this stage. 
After this new trajectory is obtained, I performed a fitting procedure with 
```
gmx trjconv -s new_md_meta.tpr -f traj_center.xtc -n index.ndx -fit rot+trans
```
Importantly, here I selected the `C-alpha` group (with 217 atoms) for the least-squares fitting and `Protein_CAL` for the output. 

Now, to visualize the whole trajectory, we have to remove the ions and the water molecules from the initial gro. 
```
gmx trjconv -s new_md_meta.tpr -f md.gro -n index.ndx -o start.gro
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

