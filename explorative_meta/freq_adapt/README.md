# Frequency adapted metadynamics

## Introduction

It is possible to recover kinetics through so called "infrequent metadynamics" simulations, where the simulations are biased in a way that minimally corrupts the dynamics of moving between metastable states. In particular, no substantial bias must be added to the transition state (TS) region. From the time needed for the CV to jump to another basin, we can recover the actual time of the jump. 

The problem of this InMetaD is that the filling of the basins requires a large amount of time. can we design a bias deposition scheme so that the frequency is high near the bottoms of the free energy basins, but decreases gradually so as to lower the risk of biasing the TS regions?

# Plumed implementation

In order to activate this adaptive metadynamics, you have to specify `FREQUENCY_ADAPTIVE=TRUE`.

$$\tau_{\text{dep}}(t)=\text{min}\left\{\tau_0 \text{max}\left(\frac{\alpha(t)}{\theta}, 1\right), \tau_c\right\}$$

- $\tau_0$ (typical frequency in MetaD): it is set by the `PACE` varible.
- $\tau_c$ (tyical frequency in InMetaD) is set by `FA_MAX_PACE `. 
- $\theta$ is the threshold value that the acceleration factor $\alpha(t)$ has to reach before triggering a change in the hill addition. This is set by the keyword `FA_MIN_ACCELERATION`. By default it is equal to 1.

By default the above expression of $\tau_{\text{dep}}(t)$ is evaluated at a pace set by `PACE`. You can change that pace using the option `FA_UPDATE_FREQUENCY`. 

## What if we want to restart? 
You need to use the `ACCELERATION_RFILE` to read the accelerations of the previous run. Remember that you have to write the keyword `ACCELERATION` if you want to compute the metadynamics acceleration factor.

The first thing you need to do is to define a file containing the acceleration factor, then you pass it to `ACCELERATION_RFILE` when the simulation is restarted (`RESTART` flag is required).

# What if we want to reweight?
We need to save the quantity `metad.rbias`, which is the instantaneous value of the bias normalized using the $c(t)$ reweighting factor. This component can be used to obtain a reweighted histogram. 

If we want to reweight as in the article by Tiwary and Parrinello, we must use a combination of `METAD` and `HISTOGRAM` actions. The $c(t)$ and the appropriate weight to apply to the configurations are given by the values labeled `rct` and `rbias`.

For example, you can set `REWEIGHTING_NGRID=200` (inside `METAD`) as in the presented script:
```
d1: DISTANCE ATOMS=1,2
metad: METAD ...
 ARG=d1 
 PACE=100 
 HEIGHT=1.2 
 SIGMA=0.02 
 BIASFACTOR=10 
 GRID_MIN=0 
 GRID_MAX=1 
 GRID_BIN=200 
 REWEIGHTING_NGRID=200
...
DUMPATOMS STRIDE=100 FILE=file.xtc
```
Then you can write a script for computing the free energy as a function of the distance that was not biased (`d2` in this case).
```
d1: DISTANCE ATOMS=1,2
d2: DISTANCE ATOMS=3,4
metad: METAD ... 
 ARG=d1
 PACE=1 
 HEIGHT=1.2 
 SIGMA=0.02 
 BIASFACTOR=10 
 GRID_MIN=0 
 GRID_MAX=1 
 GRID_BIN=200 
 REWEIGHTING_NGRID=200 
...

bias: REWEIGHT_METAD TEMP=300

HISTOGRAM ...
 ARG=d2
 GRID_MIN=0.0
 GRID_MAX=1.0
 GRID_BIN=200
 LOGWEIGHTS=bias
 LABEL=hB
...

fes: CONVERT_TO_FES GRID=hB TEMP=300
DUMPGRID GRID=fes FILE=fes.dat
```
You can call this script with the command 
```
plumed driver —-ixyz traj.xyz —plumed plumed_reweigh.dat
```







# Meaning of `UPDATE_IF` in plumed
Conditional update of other actions.
The following input instructs plumed to dump all the snapshots where an atom is in touch with the solute.

```
solute: GROUP ATOMS=1-124
coord: COORDINATION GROUPA=solute GROUPB=500 R_0=0.5

# A coordination number higher than 0.5 indicate that there is at least one
# atom of group `solute` at less than 5 A from atom number 500

UPDATE_IF ARG=coord MORE_THAN=0.5
DUMPATOMS ATOMS=solute,500 FILE=output.xyz
UPDATE_IF ARG=coord END
```