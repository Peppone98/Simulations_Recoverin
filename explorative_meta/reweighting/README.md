
# Reweighting approximation
To do this, we have to reweight, or unbias the metadynamics simulation. When you add some bias to the simulation, you are changing the underlying ensamble. You are interested in the properties in the original ensemble. The reweighting was also done in umbrella sampling, but in that case it was easier because the bias did not depend on time. Here, we simplify the picture by assuming that the bias is not changing over time. This approximation becomes reliable when the simulation time is long enough, namely when the height of the Gaussians has already decayed to zero (the decay is exponential, so it is softened after some time has passed). Under this assumption, we can use the umbrella sampling style of reweighting.

# Reasons for reweighting
In many cases you might decide which variable should be analyzed after having performed a metadynamics simulation. You might want to calculate the free energy as a function of CVs other than those biased during the metadynamics simulation. At variance with standard MD simulations, you cannot simply calculate histograms of other variables directly from your metadynamics trajectory, because the presence of the metadynamics bias potential has altered the statistical weight of each frame. To remove the effect of this bias and thus be able to calculate properties of the system in the unbiased ensemble, you must reweight (unbias) your simulation


# How can we perform a proper reweighting ?
The equilibrium average of an arbitrary position-dependent operator $O(\mathbf{R})$ can be computed as 

$$\langle O(\mathbf{R})\rangle_0=\langle O(\mathbf{R})e^{\beta[V(s(\mathbf{R}), t)-c(t)]}\rangle$$

where, on the right, the average is performed on the metadynamics run. 

The file `reweight.dat` can be called with 
```
plumed --no-mpi driver --plumed reweight.dat --noatoms > plumed.out
```
where the option `--noatoms` simply tells plumed to use the `COLVAR` file instead of using a trajectory. 

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


Be careful: remember that the free energy is defined up to a constant, so if strange numbers appear, remember to subtract the "offset". 



