

# Benchmarks

In this folder we collect the starting files for the benchmark. The plan is to make benchmarks on the short_cpuQ queue (which is the fastest). We need to collect the performances of different runs and show them in a python notebook. 

## Speed up the plumed calculation
Plumed makes use of MPI and OpenMP to parallelize some of its functions. Plumed collects atoms from an external code and sends back forces, so it is key to minimize the effect of plumed on highly parallel calculations to keep to the minimum the number of atoms used by plumed at every calculation step.


# Speed up metadynamics
Metadynamics can be sped up significantly using grids, which are activated setting the GRID_MIN and GRID_MAX keywords. This makes addition of a hill to the list a bit slower (since the Gaussian has to be evaluated for many grid points) but the evaluation of the potential very fast. Since the former is usually done every few hundred steps, whereas the latter typically at every step, using grids will make the simulation faster in particular for long runs.

For more information, search https://github.com/plumed/plumed2/blob/master/user-doc/Performances.md.



