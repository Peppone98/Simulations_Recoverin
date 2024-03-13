
# Simulations in membrane with the multisite Calcium ion

First of all, I have to enlarge the box dimensions. To this aim, I use the `.tcl` script in the folder. I saved a structure with four membranes and proteins in `4x_membr_Rec.pdb`. Use the selection
```
not water and not resname POT and not resname CLA
```
to save the `.pdb`. All the atoms in the pdb should already have thei chain ID assigned. Moreover, the calcium is already labelled as `CA` (as Charmm-gui wants). Remember that the atom IDs of the two calcium ions are now 3303 and 3304.

Note that all the lipids in the `membr_Rec.pdb` file have the chain identifier equal to `B`. 

I modify the box with these lines
```
cp 4x_membr_Rec.pdb 4x_box_modified.pdb
nano 4x_box_modified.pdb
gmx editconf -f 4x_box_modified.pdb -translate 0 4.5 0 -o 4x_box_translated.pdb
```

Then I apply the script in `CM_cut_away`. Be careful because the script does not preserve the order of the atom IDs. 
