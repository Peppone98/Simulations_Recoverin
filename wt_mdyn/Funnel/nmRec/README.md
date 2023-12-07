
# Defining the funnel 

We use the unbiased simulation to define the funnel. We have the positions assumed by the Calcium ion along the trajectory of 20 ns. We can use this to define the amplitude of the cone.

First we have to first source `tooltip.tcl` and then `funnel.tcl` from the `tooltip` folder. Then, to open the graphical interface we type `funnel_tk`. 

You can press `r` to deactivate the selection mode of the points A and B. 

A value of `Rcyl` of 1 A can be used in almost all cases. 

The orange region represents the space that will be sampled by the center of mass of the ligand. 



We must select a funnel that allows for Calcium to explore the binding pocket EF2 (inside the conical section of the funnel) and unbind without colliding with the protein on the way out (inside the cylindrical part). Overall, the funnel-shaped restraint must cover completely the entrance of the binding pocket, including the residues at the edge since they can have a recruiting effect for the ligand. 


## Parameters for the space available to the ligand
The funnel potential will be constructed as a grid file, so we need to provide dimensions to delimit it. This dimensions are defined by the following parameters:
- Min fps.lp: minimum value along the funnel axis (taking point A as the 0);
- Max fps.lp: maximum value along the funnel axis (taking point A as the 0).

ATTENTION: the value of `Min fps.lp` should be at least 0.5 A smaller than the value of `Low. wall`. Similarly, the value of `Max fps.lp` should be at least 0.5 A higher than the value of `Up. wall`. 

where `fps` that stands for funnel positioning system and `lp` for linepos. 
The red dots mark the upper and lower boundaries of the ligand along the funnel axis. If the ligand reach these positions during the simulation, an external potential is applied to the system to keep the ligand inside the funnel volume. Since the solvent is sampled in the cylindrical part of the funnel, around 3-4 Angstroms of `fps.lp` should be assigned for the solvent sampling, outside of the protein electrostatic and vdw cutoffs. These walls are necessary because if the center of mass of the ligand goes out of grid for any reason, the algorithm will output an error and the entire FM simulation will crash. For this reason, you can find the Low. wall and Up. wall parameters in the interface that should be set leaving 2-3 Angstroms from the grid edges

## Complete the configuration
When you load a molecular structure or trajectory into VMD, it is assigned an ID, and you can refer to this ID in subsequent VMD commands to perform operations or analyses specific to that particular molecular system. You can obtain the ID with the command 
```
molinfo top
```
You also have to specify the name of the ligand and then click on apply. Then you click on `apply`. 

The unset parameters in the newly generated plumed files have the `<fill>` flag. These options can be chosen with the bar menu. Always press enter and then `apply`. 


## Set the anchor point 
This atom should be chosen as close as possible to the ligand both in the bound and in the unbound state. This operation has no consequence on the quality of the results but avoids technical issues related to the periodic boundary conditions during the simulation.

## Parameters and files 
- `REFERENCE`: requires the name of the file that will be used to align the funnel to the protein during the simulation. Save the current system as a pdb and provide here the name of the pdb.
- `ANCHOR`: a protein atom that is close to the ligand along the supposed binding pathway. This is necessary in some cases to avoid periodic boundary conditions (PBC) problems and should be interactively chosen as previously done for point A and B;
- `KAPPA`: potential constant to generate the funnel-shaped restraint, requires a number in kJ/mol/nm^2 (for benzamidine around 35000 is fine).
- `k_funnel`: it sets the value for the spring constant of the funnel-shape restraint potential in kJ/(mol*nm2). 
- `reference`: with VMD I have to create a `.pdb` containing only the atoms of the target molecule. It is strongly suggested to choose the backbone atoms of secondary structures (i.e., alpha helix and beta sheet).

## Outputs
The “BIAS” file contains the information of the funnel-shape restraint potential.

As a rule of thumb, the calculation is converged if the system continues exploring the bound and unbound state in the CV space, while the computed BFES as a function of the time does not change significantly.


## Short analysis of the plumed file
`FUNNEL_PS`: this colvar evaluates the position of a ligand of interest with respect to a given line, built from the two points A and B. Since it is important that the position of the line is updated based on the motion of the macromolecule during the simulation, this colvar incorporates an alignment method. The latter uses the TYPE=OPTIMAL option to remove motions due to rotation and translation of the macromolecule with respect to a reference structure, which is provided by the user. The reference structure should be given as a pdb file, containing only the atoms of the macromolecule or a selection of them (e.g., the protein CA atoms of secondary structures).

`lp` stands for the position along the funnel line, while `ld` is the distance from the funnel line. 


## How to compute the cone section of the funnel
The cone section of the funnel is calculated with the following formula:

$$
MAX_Z=R_{cyl}+tg_{\alpha}(Z_{cc}-MIN_{s})
$$

where $tg_{\alpha}$ is the angle regulating how steep the cone is, $MIN_{s}$ is the lowest possible value assumed by fps and $MAX_Z$ is the radius of the cone base. 

## Tricks with VMD
VMD can also plot the distance between periodic images. You select two atoms belonging to two images of the same protein and then you go on `graph`. 