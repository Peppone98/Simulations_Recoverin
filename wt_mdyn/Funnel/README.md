
# Folder organization

The folder `nmRec_new` contains the latest attempt.

# Funnel metadynamics
We have to introduce the funnel restraint of the system under study, which is done with the graphical user interface implemented in VMD. 

The funnel restraint should should be placed on the system so as to include the ligand binding site in the cone section of the funnel. 

- The points A and B represent the extremes of the funnel cone.
- `Zcc` defines the switching point between the cone and the cylindric section of the funnel. 
- `alpha` defines the amplitude of the conic region, in radians. 
- `Rcyl` is the radius of the cylindric section. 

The funnel volume in orange represents the space that will be sampled by the center of mass of the ligand. The script `ffs.tcl` is a post processing script. To open the graphical interface, type `ffs_tk`. 



