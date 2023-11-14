

# Benchmarks

In this folder we collect the starting files for the benchmark. The plan is to make benchmarks on the short_gpuQ queue (which is the fastest). We need to collect the performances of different runs and show them in a python notebook. 

In order to restart the simulation from the "equilibrium" configuration at 20 ns, we need to create a new `md_meta.tpr` file. This time we can also use the `md.cpt` file for the initial velocities:
```
gmx grompp -f mdp/md.mdp -c md.gro -t md.cpt -p topol.top -o md_meta.tpr
``` 
We want `md_meta.tpr` to be able to generate 50 ns of run. We modify the `mdp/md.mdp` file accordingly. Unfortunately, the checkpoint file cannot be read from the local version of gromacs.

NOTE: we only modified the time extension of the simulationup to 100 ns. 

# Obtain a good performance with GPUs
The number of logical cores used in this case should be relatively small, for instance, `ncpus = 4, 5, 6, 8, 12, 20, 24` are already good values. Moreover, you should always add the option `-nb gpu -pme auto`. 
