# Reweight
The presence of the metadynamics bias potential has altered the statistical weight of each frame, so we need to reweight in order to explore new possible CVs.


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

# How to reweight in plumed
We need to save the quantity `metad.rbias`, which is the instantaneous value of the bias normalized using the $c(t)$ reweighting factor. This component can be used to obtain a reweighted histogram. 

If we want to reweight as in the article by Tiwary and Parrinello, we must use a combination of `METAD` and `HISTOGRAM` actions. The $c(t)$ and the appropriate weight to apply to the configurations are given by the values labeled `rct` and `rbias`.


# Type of simulation analyzed in the folder
Here we analyze a simulation obtained by means of an adaptive version of metadynamics in the frequency of the deposited Gaussians. For more informations about the setup of this simulation, see the folder `freq_adapt`. 


# Description of the files in the folder
Here we search for reweighting methods using both plumed and python (see the notebooks). There are different reweighting strategies: 
1. We read the `metad.rbias` column of the `COLVAR` file and then use the tool `REWEIGHT_METAD` using `metad.rbias` as argument. Next we use the tool `HISTOGRAM`. In this way we can reweight the trajectory using directly the `COLVAR` file (with the calling option `--noatoms`), but we can only get the reweight for the chosen CV and other variables we saved before in `COLVAR`, since `COLVAR` does not contain the whole trajectory. You can find this procedure in `rew_1.dat`.
2. We start again a metadynamics cycle, but we don't deposit any Gaussian (we impose a very large `PACE`). After this, we obtain the probability distribution as before with `HISTOGRAM` and the free energy profiles of quantities. We must call this script with `--mf_xtc`. You can find this procedure in `rew_2.dat`.
3. I think that the best method is actually do the reweight with python. In this way you don't have to provide a grid with values and you don't have to try to adjust the `BANDWIDTH` parameter used for the Kernel Density Estimation (KDE) performed by plumed. Even if the free energy profile obtained with python is not so elegant, it requires much less time to be obtained. 


Be careful: remember that the free energy is defined up to a constant, so if strange numbers appear, remember to subtract the "offset". 
 



