
# Folder organization

We keep the "good" metadynamics runs (in `wt_mdyn`, where `wt` stands for "well-tempered") separated from the non-biased runs. 

The four analyzed systems
- non-myristoylated Recoverin (`nmRec`)
- non-myristoylated Recoverin in complex with GRK1 (`nmRec_GRK1`)
- Recoverin in membrane (`membr_Rec`)
- Recoverin with GRK1 in membrane (`membr_Rec_GRK1`)
were simulated for 10 ns to recover the typical standard deviation of the distance and obtain a more relaxed structure to use in the metadynamics runs.

 The process of building up of the `.tpr` files from the `.gro` structures could be painful, so we keep it separated in the four folders 
- `nmRec`
- `nmRec_GRK1`
- `membr_nmRec`
- `membr_nmRec_GRK1`
Each folder contains the files for the setup of the systems starting from the given structure files labeled with the suffix `_start.gro`. 


The set of benchmarks for both CPUs and GPUs is in `benchmarks`.

The "trial & errors" session is placed in `explorative_meta`. In this folder we explore different variations of well-tempered metadynamics. In the folder `trial_NH`, we also tried to use plumed with Nosé-Hoover chains and velocity Verlet together, without good results. 


After a first trials & errors session with plumed, I decided to do a simple well-tempered metadynamics. 
Reasons: 
1. Geometrically adapted metadynamics 
2. Frequency adapted metadynamics 
3. Parallel bias metadynamics 
All these variations are implemented in plumed but I didn't see any research article applying these methods to physically relevant systems (only alanine dipeptide was treated). 

On the other hand, I found articles relying on the multiple walkers version of metadynamics. 


$$ F = U - TS $$

1. Energetic contribution:
2. Entropic contribution: much more relevant when $d>0.4 \AA$
