
# Collection of `.tpr` files for Well-Tempered (WT) Metadynamics (Mdyn)

Here we collect all the `.tpr` for each of the four simulations, with and without the membrane. We use the same parameters, barostats and thermostats as Ester used. In this way, we will discover the best method between metadynamics and umbrella sampling. 



# Observations on the second order coupling algorithms 
In all the systems we implement the so-called "second order coupling" with Parrinello-Rahman (PR) barostat and the Nosè-Hoover (NH) thermostat. 

First order coupling algorithms usually do not have issues with stability due to oscillations, so choosing the value for `tau` is not so critical. But `tau_t` needs to be small enough to effectively remove energy drift due to integration errors. `tau_p` should not be too small, as scaling the volume too fast might cause instabilities. 

Remember that in NH you have a constant $Q$ usually called mass parameter that fixes the strenght of the coupling between the equation of motion and the equation for the fictitious momentum that keeps the kinetic energy around the target value.

In general, the lower the `tau` value, the faster the coupled parameter (temperature for NH or pressure for PR) is pulled towards it’s reference value.

# Systems without membrane
We take the two equilibrated structures `.gro` and we use the same `.mdp` file for generating the `.tpr`.


The next step is to send these files in different folders. 


In most simulations of membranes the pressure coupling is limited to the z component, thus keeping fixed the x-y shape of the system.

`nose-hoover`: temperature coupling using a Nose-Hoover extended ensemble. in this case tau-t controls the period of the temperature fluctuations at equilibrium, which is slightly different from a relaxation time. For NVT simulations the conserved energy quantity is written to the energy and log files.
`tau-t`: time constant for coupling, (one for each group in `tc-grps`).
`nsttcouple`: the frequency for coupling the temperature. The default value of -1 sets nsttcouple equal to 100, or fewer steps if required for accurate integration (5 steps per tau for first order coupling, 20 steps per `tau` for second order coupling). 


# System with membrane
