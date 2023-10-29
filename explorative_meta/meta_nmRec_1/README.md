
# First explorative metadynamics simulation

From our benchmarks, the most natural choices for the execution of the jobs are:
- `ncpus=12` and `mpiprocs=6` on GPUs (I started this on the cluster)
- `ncpus=24` and `mpiprocs=4` on CPUs

I start the simulation from the last configuration of the "equilibrium" unbiased trajectory. The run will be 50 ns long. 

## Setting up the simulation
1. Be careful about the `GRID` option: this may cause exceptions in plumed because it might look for values outside the specified range.
2. Probably the `PACE` parameter has to be increased to reach a quasi-equilibrium configuration between each deposition.

### Small premise
I decided to consider only one CV (the distance between the coordinant Oxygens and Calcium ion) because this run has to be reweighted. The reweight procedure is intrinsically subject to (small) systematic errors whose contribute can increase with the number of CVs employed in the run. Moreover, I wanted to have a quantitative check with the results obtained by Ester.


## Short introduction
In general, metadynamics can be performed with multiple CVs. We will refer to these variables with $\{s_i\}$, with $i=1, 2$. The well-tempered version of metadynamics provides a bias potential of the type 
$$
B(\{s_i\}, t)=\sum_{t'=\tau_G, 2\tau_G, ...}^{t} W \exp{\left(-\frac{B(\{s_i(t')\}, t')}{\Delta T}\right)} \exp{\left(-\sum_{i=1}^{2}\frac{(s_i-s_i(t'))^2}{2\sigma_i^2}\right)}
$$
This method ensures that the bias converges more smoothly than standard metadynamics. Notice that the bias lives in the $\{s_i\}$-space and it is centered around the value of the $\{s_i(t')\}$ coordinates, where $t'$ represents the discrete times $\tau_G, 2\tau_G, ...M\tau_G$ at which a new bias is added.

Notice that $B(\{s_i\}, t)$ can be represented by an array of numbers in the time domain: in fact, you have access to the current value of the coordinates $\{s_i\}$ and the same coordinates evaluated at the "deposition times" $t'$, therefore, you can always compute the difference $s_i-s_i(t')$ as a function of the actual simulation time. This difference will be zero whenever a new Gaussian is deposited. 


## Restart option in plumed
The command `RESTART` should appear at the beginning of the input file. Remember to put the `-cpi` option in the gromacs command. 


# PBMetad
This method draws inspiration from the bias-exchange variants of Metadynamics. It improves sampling efficiency by exchanging a single $n$-dimensional bias with $n$-one dimensional biases. 