# Dynamically adapted Gaussians

To define a time-dependent adaptive covariance at time $t$ we compute the average value of the CVs and all the elements of the covariance matrix from the last part of the trajectory. The center of the Gaussian is placed at the computed average value. To select the segment of trajectory over which we perform the average we found convenient to introduce an exponential weighting function with characteristic decay time $\tau_D$. This induces a differential equation in $\sigma_{ij}(t)$ which is dynamically solved along the trajectory. If we work in a one-dimensional space, we can write 

$$\bar{s}(t)=\frac{1}{\tau_D}\int_{0}^{t}dt' \ s(t')e^{-(t-t')/\tau_D}$$

and 

$$\sigma^2(t)=\frac{1}{\tau_D}\int_0^{t}dt' \ [s(t')-\bar{s}(t)]^2e^{-(t-t')/\tau_D}$$

# Geometrically adapted Gaussians
The $\sigma$ is a function of the atomic positions of the six coordinating oxygens and the calcium ion. We can update $\sigma$ according to a first order expansion in terms of the atomic positions 

$$\sigma^2_{ij}=\sigma_G^2\sum_{k}\frac{\partial s_i}{\partial q_k}\frac{\partial s_j}{\partial q_k}$$


IMPORTANT: in this folder I only present a possible script for the geometrically adaptive metadynamics. This produces only small variations with respect to the intial value $\sigma=0.007$, so I decided not to continue the run. 