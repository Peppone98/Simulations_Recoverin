
# Generating the starting configurations for the multiple walkers metadynamics

Once these configurations are obtained, they can be used to enhance the sampling of each type of metadynamics. 


## Approach involving unbiased dynamics 
The idea is to perform 100 ns of unbiased simulation, calculate the PCA, choose representative configurations and equilibrate them. 

## Approach with a pilot metadynamics
Alternatively, I can generate representative configurations for each cluster using the results from a metadynamics run instead of an unbiased run. For each identified cluster, I can select representative structures based on their positions in the collective variable space.

It's important to note that the metadynamics potential introduces a bias to the system, and the equilibration of the generated structures is crucial to remove any artifacts introduced by the bias. Additionally, the choice of collective variables and other metadynamics parameters should be carefully considered to ensure that the metadynamics simulation captures the relevant aspects of the system's dynamics.

I could use the information from the single walker metadynamics with the wall. I can say this: "I wanted to generate plausible configurations with the ligand still inside the pocket, so I decided to put a (unphysical) wall at 1.3 nm. In other words, I want to explore only the bound state". 


## Necessity of the barrier
The barrier was needed because an "aggressive" metadynamics could quickly lead to an unbuond state, which in turn leads to poor sampling of the equilibrium bound state. In fact, if the calcium ion leaves the binding pocket, then it might take a long time to enter again the pocket. So I decided to be conservative and keep the ion inside. 

IDEA: I can keep only those configurations that do not reach the barrier at 1.3 nm, for instance, I can put a cut-off of 1 nm. In thi way, I consider only those configurations that are influenced by an "a priori" choice. 

I can take the first 60 ns of dynamics for each multiple walker run. The problem is that I have to do the solvation again in the case of the nmRec. But I think I can manage it. 

For this reason, maybe, with this approach I can start with the membrane case. 

# Generate the configurations from a different criterium
I only have to consider the distance. How can I do this? 
Well I can skip the clustering process and just take configurations at approximately equal distances. 
Maybe in this way I can define only one funnel. 


In case you want to use plumed on cluster, just do
```
module load gcc91
module load openmpi-3.0.0
module load BLAS
module load gsl-2.5
module load lapack-3.7.0
module load python-3.8.13 
source /home/giuseppe.gambini/usr/src/gmx_plumed.sh
```

