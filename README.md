
# Folder organization

We keep the "good" metadynamics runs (in `mdyn`) separated from the non-biased runs. The build up of the `.tpr` files for the dynamics could be painful, so we keep it separate in the four folders 
- `nmRec`
- `nmRec_GRK1`
- `membr_nmRec`
- `membr_nmRec_GRK1`

The set of benchmarks for both CPUs and GPUs is in `benchmarks`.

The "trial & errors" session is placed in `explorative_meta`. 