
# Plumed analysis
For these little runs on the cluster (where the trajectories are stored), we can either run a `pbs` file or running directly plumed in our home after the definition of the environment variables and the loading of the modules. 

## Setup of the plumed file

Here we setup a plumed script to extract information about our unbiased simulation. We first compute the distance between the center of mass of `ASP74 OD2`, `ASN76 OD1`, `ASP78 OD2`, `THR80 O`, `GLU85 OE1`, `GLU85 OE2` and the `301CAL`. After this, we can further expand our space of trial CVs and compute other non linear functions of the coordinates. 

The numbers associated to the atoms listed above are the following: `1175`, `1196`, `1222`, `1245`, `1330`, `1331` and `3262` for the calcium atom. 

Remember that `MOLINFO` is useful only if you want to refer to atoms without explicitly using their index. 

Let's briefly describe the commands of plumed:
1. `DISTANCE`: by default the distance is computed taking into account periodic boundary conditions.
2. `WHOLEMOLECULES`: This action is used to rebuild molecules that can become split by the periodic boundary conditions. It is needed since some MD dynamics code (e.g. gromacs) can break molecules during the calculation. Running some CVs without this command can cause there to be discontinuities changes in the CV value and artifacts in the calculations
3. `DUMPATOMS`: can be used to output the positions of a particular set of atoms. The atoms required are output in a xyz or gro formatted file. Importantly, if your input file contains actions that edit the atoms position (e.g. `WHOLEMOLECULES`) and the `DUMPATOMS` command appears after this instruction, then the edited atom positions are output. 
4. `COM`: calculate the center of mass for a group of atoms. The computed center of mass is stored as a virtual atom that can be accessed in an atom list through the label for the `COM` action that creates it. When running with periodic boundary conditions, the atoms should be in the proper periodic image. This is done automatically since `PLUMED 2.2`, by considering the ordered list of atoms and rebuilding the molecule using a procedure that is equivalent to that done in `WHOLEMOLECULES`. Notice that rebuilding is local to this action. This is different from `WHOLEMOLECULES` which actually modifies the coordinates stored in plumed.
5. `GROUP ATOMS`: define a group of atoms so that a particular list of atoms can be referenced with a single label in definitions of CVs or virtual atoms.



I think we can avoid the `WHOLEMOLECULES` option if we decide to post-process our trajectory with `trjconv` in gromacs. But still, how does plumed read the trajectory ? 


## Get the reference structure for the `MOLINFO` commmand
```
gmx editconf -f md.tpr -o reference.pdb
```

## How to use `WHOLEMOLECULES`
```
WHOLEMOLECULES ENTITY0=1-100
e2e: DISTANCE ATOMS=1,100 NOPBC
RESTRAINT ARG=e2e KAPPA=1 AT=5
```
Notice that `NOPBC` is used to be sure in `DISTANCE` that if the end-to-end distance is larger than half the simulation box the distance is compute properly. Also notice that, since many MD codes break molecules across cell boundary, it might be necessary to use the `WHOLEMOLECULES` keyword (also notice that it should be before distance).


## Start the analysis with plumed 
```
plumed driver --plumed get_distances.dat --mf_xtc md.xtc
```

## Standard deviation 
Using 
```
gnuplot> stats "distances.txt" u 2
```
we can get the standard error of the array of distances. The std is equal to 0.0067. We can approximate this value with 0.007. 