
# PBMetaD with adaptive Gaussians

This method draws inspiration from the bias-exchange variants of Metadynamics. It improves sampling efficiency by exchanging a single $n$-dimensional bias with $n$-one dimensional biases.

# How does PBMetaD work?
In principle, multiple mono-dimensional bias potentials are applied in parallel.

$$V(s_1, t)...V(s_N, t)$$

where

$$V(s_i, t)=\sum_{k\tau<t}W_i(k\tau)\exp{\left(-\frac{[s_i(t)-s_i(k\tau)]^2}{2\sigma_i^2}\right)}$$

To ensure the convergence of each mono-dimensional bias at each deposition rate, we introduce the so-called conditional term: 

$$W_i(k\tau)=W_0\frac{\exp{\{V(s_i,t)/kT\}}}{\sum_j\exp{\{V(s_j,t)/kT\}}}$$


# Bidimensional implementation
The difference with the other runs is that here we have to analyze two diffrent `HILLS` file, namely `HILLS_d1` ($s_1$) and `HILLS_coord` ($s_1$). In PBMetaD at any given time step either $V(s_1,t)$ or $V(s_2,t)$ is added to the underlying potential $U(\mathbf{R})$. An auxiliary discrete variable $\mathbf{\eta}=(\eta_1, \eta_2)$ (with either $\mathbf{\eta}=(1, 0)$ or $\mathbf{\eta}=(0, 1)$) is introduced for turning on one of the two bias potentials at a time. 

Thus, we sample the following probability distribution

$$P(\mathbf{R}, \mathbf{\eta})\propto \exp{\{-\beta [U(\mathbf{R})+ \eta_1 V(s_1, t)+\eta_2 V(s_2, t)]\}}$$

The value of $\mathbf{\eta}$ is sampled through a Monte-Carlo scheme. 

If we marginalize the distribution $P(\mathbf{R}, \mathbf{\eta})$ with respect to $\mathbf{\eta}$, we obtain 

$$P(\mathbf{R})\propto \exp{\{-\beta[U(\mathbf{R})+ V_{PB}(s_1, s_2, t)]\}}$$

with 

$$V_{PB}(s_1, s_2, t)=\frac{1}{\beta}\log{\{\exp{\{-\beta V(s_1, t)\}}+\exp{\{-\beta V(s_2, t)\}}\}}$$

This effective (or marginal) bias potential is clearly different from the concurrent metadynamics potential, which is the sum of the two biases. 

We want to compute the conditional probability $P(\mathbf{\eta}|\mathbf{R})$ of observing a given $\eta$, when we are given a configuration $\mathbf{R}$. This probability is known since we have $P(\mathbf{R})$ and $P(\mathbf{\eta}, \mathbf{R})$. We can write 

$$P(\mathbf{\eta}=(1 0)|\mathbf{R})=\frac{\exp{(-\beta V(s_1, t))}}{\exp{(-\beta V(s_1, t))}+\exp{(-\beta V(s_2, t))}}$$

and 

$$P(\mathbf{\eta}=(0 1)|\mathbf{R})=\frac{\exp{(-\beta V(s_2, t))}}{\exp{(-\beta V(s_1, t))}+\exp{(-\beta V(s_2, t))}}$$

We know that in WTMetaD the deposition rate decreases with time, according to the time spent in the current phase space basin. The standard rate of deposition is given by 

$$\omega(t)=\omega_0\exp{\left(-\frac{V(s, t)}{k\Delta T}\right)}$$

where the keyword `PACE` specifies $\omega_0$. In PBMetaD we have a different deposition rate law. We still want the rate to decrease whenever the bias becomes significant. 

$$\omega_1(t)=\omega_1\exp{\left(-\frac{V(s_1, t)}{k\Delta T}\right)}P(\mathbf{\eta}=(1 0)|\mathbf{R})$$

and 

$$\omega_2(t)=\omega_2\exp{\left(-\frac{V(s_2, t)}{k\Delta T}\right)}P(\mathbf{\eta}=(0 1)|\mathbf{R})$$

With this choice, the two bias potentials exactly converge to the correct monodimensional free energies. The full high-dimensional free energy can be easily recovered by applying a reweighting technique. In PBMetaD we have a single time-dependent potential $V_{PB}(s_1, s_2, t)$ that becomes quasi-static in the long limit. Therefore, we should discard the first part of the simulation and then use the umbrella sampling reweighting 

$$w\propto \exp{(-V_{PB}(s_1, s_2, t)/kT)}$$


# PBMetaD with walkers
Additional replicas can be utilized in a multiple-walkers fashion, in which several copies of the system perform a PBMetaD simulation and share the accumulated bias potentials.
 