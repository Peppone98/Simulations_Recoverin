

# Benchmarks

In this folder we collect the starting files for the benchmark. The plan is to make benchmarks on the short_cpuQ queue (which is the fastest). We need to collect the performances of different runs and show them in a python notebook. 

In order to restart the simulation from the "equilibrium" configuration at 20 ns, we need to create a new `md_meta.tpr` file. This time we can also use the `md.cpt` file for the initial velocities:
```
gmx grompp -f mdp/md.mdp -c md.gro -t md.cpt -p topol.top -o md_meta.tpr
``` 
We want `md_meta.tpr` to be able to generate 50 ns of run. We modify the `mdp/md.mdp` file accordingly. Unfortunately, the checkpoint file cannot be read from the local version of gromacs.

## Speed up the plumed calculation
Plumed makes use of MPI and OpenMP to parallelize some of its functions. Plumed collects atoms from an external code and sends back forces, so it is key to minimize the effect of plumed on highly parallel calculations to keep to the minimum the number of atoms used by plumed at every calculation step.


# Speed up metadynamics
Metadynamics can be sped up significantly using grids, which are activated setting the GRID_MIN and GRID_MAX keywords. This makes addition of a hill to the list a bit slower (since the Gaussian has to be evaluated for many grid points) but the evaluation of the potential very fast. Since the former is usually done every few hundred steps, whereas the latter typically at every step, using grids will make the simulation faster in particular for long runs.

For more information, search https://github.com/plumed/plumed2/blob/master/user-doc/Performances.md.

## Parameters of the simulations
1. Pace of deposition of the Gaussian: every 100 steps.
2. Height of the Gaussians: 1.2 kJ/mol.
3. Standard deviation sigma: 0.007.
4. Bias factor: 8
5. Extremes of the grid: [0, 0.4]

### Guidelines for chooosing the parameters
1. If $\Delta T$ is set to be small, the system will not cross very high barriers, in fact, $T+\Delta T$ can be regarded as a sort of fictitious temperature for the CVs. We can also say that $\Delta T$ is a measure of how fast the amount of bias decreases to zero. 
2. Usually when people do metadynamics, they set the initial height of the Gaussian $W_0$ to $k_BT/2$
3. Usually the bias factor $(T+\Delta T)/T$ is set in the range $[5, 10]$. Typically, you choose 10 for biological applications
4. In the determination of the width of the Gaussian $\sigma$, you look at the fluctuations of the CVs in an unbiased simulation. 

### Guidelines for choosing the CV
1. Your CV should discriminate between relevant metastable states
2. Include all the slow modes of a process. This is difficult because most of the times you don't know the pathways that take between the metastable states. If your CV does not include a slow mode, it will probably do something weird, so metaD gives you some clues as to wether your "coarse-grained" description is valid or not.
3. You need a small number of CVs

## General idea
The well-temperad version of metadynamics provides a bias potential of the type 
$$
B(\{s_i\}, t)=\sum_{t'=\tau_G, 2\tau_G, ...}^{t} W \exp{\left(-\frac{B(\{s_i(t')\}, t')}{\Delta T}\right)} \exp{\left(-\sum_{i=1}^{2}\frac{(s_i-s_i(t'))^2}{2\sigma_i^2}\right)}
$$
This method ensures that the bias converges more smoothly than standard metadynamics. Notice that the bias lives in the $\{s_i\}$-space and it is centered around the value of the $\{s_i(t')\}$ coordinates, where $t'$ represents the discrete times $\tau_G, 2\tau_G, ...M\tau_G$ at which a new bias is added. 

### Popular tricks
1. Coupling metaD with replica exchange. You have a bias potential driving the dynamics, but if you got barriers in the transverse DOFs, the parallel tempering is helping the system to cross these and explore more phase space.
2. You can reweight your simulation in order to see the free energy difference with other CVs. 


# Obtain a good performance with GPUs
The number of logical cores used in this case should be relatively small, for instance, `ncpus = 4, 5, 6, 8, 12, 20, 24` are already good values. Moreover, you should always add the option `-nb gpu -pme auto`. 
