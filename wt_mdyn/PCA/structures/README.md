
# Equilibration of the initial strucures

We consider a combination of restrained and unrestrained dynamics. We could monitor quantities such as RMSD, potential energy, and temperature, during equilibration to assess stability. 

I think that 200 ps of NVT, 200 of NPT and then 1 ns of MD should be enough. 

We need the topology and `.itp` files in order to build the new `.tpr` for the equilibrations. For this reason, we temporarily move the `.pdb` files in the `tpr_generation` folder. 

I use 400 kJ/mol as restraint over the protein and the ion

Importantly, I impose a restraint also on the ion. This restraint can help to stabilize the ion in the binding site and prevent it from drifting too far away. 

## Commands sent from `tpr_generation/membr_Rec/starting_struct`
```
gmx grompp -f ../mdp_struct/nvt.mdp -c ref_0.pdb -r ref_0.pdb -p ../topol.top -o nvt_0.tpr
```
```
gmx grompp -f ../mdp_struct/npt.mdp -c nvt_0.gro -r nvt_0.gro -p ../topol.top -o npt_0.tpr
```
```
gmx grompp -f ../mdp_struct/md.mdp -c npt_0.gro -r npt_0.gro -p ../topol.top -o md_0.tpr
```


## What about the choice of 1 nm as threshold distance?

Smaller ligands (such as the calcium ion) might require a smaller distance threshold to be considered within a binding pocket. Larger ligands may interact with a protein over a more extended range.

Plus, we don't want to consider interactions with residues just outside the pocket (identified with the residues of the coordinating oxygens). 

Usuallly, distances in the range of 4 to 6 angstroms are often considered for defining interactions within a pocket, but this is not a strict rule. 


# Extracting the frames from the cluster
```
module load gcc91
module load openmpi-3.0.0
module load BLAS
module load gsl-2.5
module load lapack-3.7.0
module load python-3.8.13 
source /home/giuseppe.gambini/usr/src/gmx_plumed.sh
```
```
gmx_mpi trjconv -f traj_comp.xtc -s md_meta.tpr -dump 546 -o ref_0.pdb
```
