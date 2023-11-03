
# PBMetaD with adaptive Gaussians

## Dynamically adapted Gaussians

To define a time-dependent adaptive covariance at time $t$ we compute the average value of the CVs and all the elements of the covariance matrix from the last part of the trajectory. The center of the Gaussian is placed at the computed average value. To select the segment of trajectory over which we perform the average we found convenient to introduce an exponential weighting function with characteristic decay time $\tau_D$. This induces a differential equation in $\sigma_{ij}(t)$ which is dynamically solved along the trajectory. If we work in a one-dimensional space, we can write 
$$
\bar{s}(t)=\frac{1}{\tau_D}\int_{0}^{t}dt' \ s(t')e^{-(t-t')/\tau_D}
$$
and 
$$
\sigma^2(t)=\frac{1}{\tau_D}\int_0^{t}dt' \ [s(t')-\bar{s}(t)]^2e^{-(t-t')/\tau_D}
$$

## Geometrically adapted Gaussians
We introduce a dependence of $\sigma^2$ on the coordinates $\{q_{\alpha}\}$. 


# How does PBMetaD work?
In principle, multiple mono-dimensional bias potentials are applied in parallel.
$$V(s_1, t)...V(s_N, t)$$
where
$$V(s_i, t)=\sum_{k\tau<t}W_i(k\tau)\exp{\left\{-\frac{[s_i(t)-s_i(k\tau)]^2}{2\sigma_i^2}\right\}}$$

To ensure the convergence of each mono-dimensional bias at each deposition rate, we introduce the so-called conditional term: 

$$W_i(k\tau)=W_0\frac{\exp{\{V(s_i,t)/kT\}}}{\sum_j\exp{\{V(s_j,t)/kT\}}}$$


