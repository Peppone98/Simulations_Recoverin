# Several trails, many errors
All the trial simulations in this folder are performed with the non-mirystoylated Recoverin (`nmRec`) without GRK1 and without the membrane. 

# Folder organization 
- The folder `meta_nmRec_1` contains the first metadynamics simulation with a very high rate of deposition (`PACE=100`). The grid $[0, 0.4]$ in this case was chosen too small for our purposes.
- In `meta_nmRec_2` I changed the deposition rate to `PACE=1000` and made the `GRID` similar to the one chosen by Ester, namely $[0, 1.6]$. In this case I also modified the height of the Gaussian to 1 kJ/mol. Here I also introduced a wall at 1.3 nm to explore only the interesting region.  


# Mainly explored options of plumed 
- `CALC_RCT`: this keyword turns on the calculation of the time dependent constant $c(t)$ that we will use when reweighting the simulations. By default $c(t)$ is updated every time the bias changes
- `RCT_USTRIDE`: the update stride for calculating the $c(t)$ reweighting factor.
- `ADAPTIVE`: we have the possibility of using Gaussians whose variance is adjusted on the fly to the local properties of the free-energy surface. Two different prescriptions are suggested: one is based on the local diffusivity (`ADAPTIVE=DIFF`) and the other on the local geometrical properties (`ADAPTIVE=GEOM`). 
- `FREQUENCY ADAPTIVE`: frequency-adaptive metadynamics fills the free energy basin quickly at the beginning of the simulation, but adds the bias slowly at the latter stage when the system moves close to the transition state regions.


# Problem of correlation
If we have more than one CV, we have the insertion of a multidimensional Gaussians. This Gaussians are defined with the covariance matrix. We might have problems in considering correlated CVs since the non-diagonal elements of this covariance matrix become important. 





