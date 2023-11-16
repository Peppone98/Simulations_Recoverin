# Frequency adapted metadynamics
The idea here is to decrease the frequency of addition of Gaussians in proximity of the transitions between basins. 

IMPORTANT: from my point of view, the implementation of this variant seems to be problematic, as it is shown in the python notebook. 

# Plumed implementation

In order to activate this adaptive metadynamics, you have to specify `FREQUENCY_ADAPTIVE=TRUE`.

$$\tau_{\text{dep}}(t)=\text{min}\left\{\tau_0 \text{max}\left( \frac{\alpha(t)}{\theta}, 1 \right), \tau_c\right\}$$

- $\tau_0$ (typical frequency of deposition in MetaD): it is set by the `PACE` varible.
- $\tau_c$ (tyical frequency in InMetaD) is set by `FA_MAX_PACE`. 
- $\theta$ is the threshold value that the acceleration factor $\alpha(t)$ has to reach before triggering a change in the hill addition. This is set by the keyword `FA_MIN_ACCELERATION`.

By default the above expression of $\tau_{\text{dep}}(t)$ is evaluated at a pace set by `PACE`. You can change that pace using the option `FA_UPDATE_FREQUENCY`. 


# What if we want to restart an adaptive frequency simulation ? 
You need to use the `ACCELERATION_RFILE` to read the accelerations of the previous run. Remember that you have to write the keyword `ACCELERATION` if you want to compute the metadynamics acceleration factor.

The first thing you need to do is to define a file containing the acceleration factor, then you pass it to `ACCELERATION_RFILE` when the simulation is restarted (`RESTART` flag is required).



# What if we want to reweight?
We need to save the quantity `metad.rbias`, which is the instantaneous value of the bias normalized using the $c(t)$ reweighting factor. This component can be used to obtain a reweighted histogram. 

If we want to reweight as in the article by Tiwary and Parrinello, we must use a combination of `METAD` and `HISTOGRAM` actions. The $c(t)$ and the appropriate weight to apply to the configurations are given by the values labeled `rct` and `rbias`.


# What about recovering the kinetics of a process from metadynamics ?

It is possible to recover kinetics through so called "infrequent metadynamics" simulations, where the simulations are biased in a way that minimally corrupts the dynamics of moving between metastable states. In particular, no substantial bias must be added to the transition state (TS) region. From the time needed for the CV to jump to another basin, we can recover the actual time of the jump. 

The problem of this InMetaD is that the filling of the basins requires a large amount of time. 

