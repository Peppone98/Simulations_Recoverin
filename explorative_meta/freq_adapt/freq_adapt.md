
# Adaptive metadynamics

## Frequency adapted deposition rate

It is possible to recover kinetics through so called "infrequent metadynamics" simulations, where the simulations are biased in a way that minimally corrupts the dynamics of moving between metastable states. In particular, no substantial bias must be added to the transition state (TS) region. From the time needed for the CV to jump to another basin, we can recover the actual time of the jump. 

The problem of this InMetaD is that the filling of the basins requires a large amount of time. can we design a bias deposition scheme so that the frequency is high near the bottoms of the free energy basins, but decreases gradually so as to lower the risk of biasing the TS regions?

$$
\tau_{\text{dep}}(t)=\text{min}\left\{\tau_0 \text{max}\left(\frac{\alpha(t)}{\theta}, 1\right), \tau_c\right\}
$$
- $\tau_0$ (typical frequency in MetaD): it is set by the `PACE` varible.
- $\tau_c$ (tyical frequency in InMetaD) is set by `FA_MAX_PACE `. 
- $\theta$ is the threshold value that the acceleration factor $\alpha(t)$ has to reach before triggering a change in the hill addition. This is set by the keyword `FA_MIN_ACCELERATION`. 

By default the above expression of $\tau_{\text{dep}}(t)$ is evaluated at a pace set by `PACE`. You can change that pace using the option `FA_UPDATE_FREQUENCY`. 

### What if we want to restart? 
You need to use the `ACCELERATION_RFILE` to read the accelerations of the previous run. 