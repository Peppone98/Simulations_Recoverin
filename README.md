
# Folder organization

We keep the "good" metadynamics runs (in `wt_mdyn`, where `wt` stands for "well-tempered") separated from the non-biased runs.

 The process of building up of the `.tpr` files from the `.gro` structures could be painful, so we keep it separated in the four folders 
- `nmRec`
- `nmRec_GRK1`
- `membr_nmRec`
- `membr_nmRec_GRK1`



The set of benchmarks for both CPUs and GPUs is in `benchmarks`.

The "trial & errors" session is placed in `explorative_meta`. In this folder we explore different variations of well-tempered metadynamics. In the folder `trial_NH`, we also tried to use plumed with Nosé-Hoover chains and velocity Verlet together, without good results. 