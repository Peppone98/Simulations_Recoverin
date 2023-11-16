
# Second run 
Here we present a second metadynamics run with `PACE=1000`. The configurations should be less "stressed" with respect to the case of `PACE=100` of `meta_nmRec_1`. 

Notice the presence of the upper wall in the `meta.dat` to prevent the values of the CV distance to go beyond 1.3 nm. The choice of this restraint is also related to the cut-off of the electrostatic interactions $r_{\text{Coulomb}}=1.2$ nm implemented in the gromacs `.mdp` starting file. 


# Discussion about the parameters
I decided to continue this simulation because I think the chosen parameters are quite good. 

1. If $\Delta T$ is set too small, the system will not cross very high barriers, in fact, $T+\Delta T$ can be regarded as a sort of fictitious temperature for the CVs. On the other hand, if $\Delta T$ is too high, the increment of the bias potential remains high even after a long time spent in a certain basin (we almost reach the standard metadynamics limit). In other words, $\Delta T$ is a measure of how fast the amount of bias decreases to zero. I think the bias factor $\gamma=\Delta T+T/T=8$ might be a good compromise. Usually the bias factor is set in the range $[5, 10]$ for biological applications.
2. Usually when people do metadynamics, they set the initial height of the Gaussian $W_0$ to $k_BT/2$. This is of course an approximation. Based on this, I set 1.0 kJ/mol in the `meta.dat` file. 
3. In the determination of the width of the Gaussian $\sigma$, I looked at the fluctuations of the CVs in an unbiased simulation. 


# IMPORTANT: this simulation is continued in the folder `wt_mdyn/nmRec` 


 


