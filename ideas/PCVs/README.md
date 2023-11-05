
# Coarse-grain oriented metadynamics 




## Coarse-grain model 


## Path collective variables (PCV)
We divide the space into multidimensional isosurfaces. Our aim is to find the low free energy path that connects an initial state $X_A$ with $X_B$. We define the CV

$$S(X)=\frac{\sum_i i \exp{(-\lambda|X-X_i|)}}{\sum_{i}\exp{(-\lambda|X-X_i|)}}$$

where $X_i$ represent all the intermediate configurations, let us call them "way markers". 

$$Z(X)=\frac{1}{\lambda}\log{\left(\sum_i \exp{(-\lambda|X-X_i|)}\right)}$$

This other CV measures the distance between the instantaneous configuration $X$ and the path that is marked out using the way markers. The variables $S(X)$ and $Z(X)$ are widely in the literature on modelling conformational changes of biomolecules.

When the PCVs are approximately equally separate, we can use a recipe for calculating the $\lambda$ factor. 


## Possible functions for computing the distance
`TARGET`: it measures the Pythagorean distance from a particular structure measured in the space defined by some set of collective variables. 
`RMSD`: 
`PCAVARS`: projection on principal component eigenvectors or other high dimensional linear subspace. 



## How to collect the set of reference frames that serve as the way markers on your `PATH`?
The first thing that you will need to double check is the spacing between the frames in your `PATH`. Let's suppose that your `PATH` has $N$ of these way markers upon it you will need to calculate is the $N \times N$ matrix of distances.



## Restraints 

One idea is to apply a conical restraint such as the one employed in funnel metadynamics (FM). For strict friends, "metadinamica a imbuto".  

We must consider all the difficulties deriving from the tayloring of the shape of the funnel. 

Moreover, there exists a way in which the binding constant can be estimated. This takes into account also entropic corrections due to the limited number of configurations available. 

The reason why we need many intermediate snapshots of the CG trajectory to be taken is that we have to minimize the effect of the "walls" that restrict the values of the CVs in plumed. 