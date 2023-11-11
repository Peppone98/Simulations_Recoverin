
# Collection of `.tpr` files for Well-Tempered (WT) Metadynamics (Mdyn)

Here we collect all the `.tpr` for each of the four simulations, with and without the membrane. We use the same parameters, barostats and thermostats as Ester used. In this way, we will discover the best method between metadynamics and umbrella sampling. 



# Observations on the second order coupling algorithms 
In all the systems we implement the so-called "second order coupling" with Parrinello-Rahman (PR) barostat and the Nosè-Hoover (NH) thermostat. 

First order coupling algorithms usually do not have issues with stability due to oscillations, so choosing the value for `tau` is not so critical. But `tau_t` needs to be small enough to effectively remove energy drift due to integration errors. `tau_p` should not be too small, as scaling the volume too fast might cause instabilities. 

Remember that in NH you have a constant $Q$ usually called mass parameter that fixes the strenght of the coupling between the equation of motion and the equation for the fictitious momentum that keeps the kinetic energy around the target value.

In general, the lower the `tau` value, the faster the coupled parameter (temperature for NH or pressure for PR) is pulled towards it’s reference value.

## Parameters to be fixed
`nose-hoover`: temperature coupling using a Nose-Hoover extended ensemble. In this case tau-t controls the period of the temperature fluctuations at equilibrium, which is slightly different from a relaxation time. For NVT simulations the conserved energy quantity is written to the energy and log files.
`tau-t`: time constant for coupling, (one for each group in `tc-grps`). 
`md-vv`: a velocity Verlet algorithm (used also by Ester). The advantage of this integrator is more accurate, reversible Nose-Hoover and Parrinello-Rahman coupling integration based on Trotter expansion, as well as (slightly too small) full step velocity output. This all comes at the cost off extra computation, especially with constraints and extra communication in parallel. Note that for nearly all production simulations the integrator=`md` integrator is accurate enough.
`nsttcouple`: I don't really have to set this one.

As a rule of thumb, `tau-t` should be at least 20 times larger than `nsttcouple*dt=0.002`. For velocity Verlet integrators `nsttcouple` is set to 1.

We fix `tau-t` to 0.5 ps and `tau-p` equal to 2.0 ps. 


# Systems without membrane
We take the two equilibrated structures `.gro` and we use the same `.mdp` file for generating the `.tpr`.
```
gmx grompp -f md.mdp -c nmRec.gro -p topol.top -o nmRec.tpr
```
```
gmx grompp -f md.mdp -c nmRec_GRK1.gro -p topol.top -o nmRec_GRK1.tpr
```

# System with membrane

In most simulations of membranes the pressure coupling is limited to the z component, thus keeping fixed the x-y shape of the system.


# Next step in the procedure

We send these `.tpr` files on the cluster with the `.dat`, `.pdb` and `.pbs` files. A convenient strategy is to directly send the folder (see `WTMdyn` folder). 

# Possible error
Plumed is not yet compatible with GROMACS new modular simulator.

GROMACS will automatically use the modular simulator for the velocity verlet integrator (integrator = `md-vv`). 