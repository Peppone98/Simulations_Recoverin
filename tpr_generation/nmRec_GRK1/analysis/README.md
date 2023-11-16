
# Prepare the reference for plumed

We want to perform the same analysis performed on the recoverin alone. 

In this case, we also have the rhodopsin kinase (GRK1), which is inhibited by the calcium-binding protein recoverin. 

Be careful because the number associated to each atom may change. We remind that the group of atoms we need to keep track of is `ASP74 OD2`, `ASN76 OD1`, `ASP78 OD2`, `THR80 O`, `GLU85 OE1`, `GLU85 OE2` (I checked that the atoms are the same). 

## Get the reference structure for the `MOLINFO` commmand
```
gmx editconf -f md.tpr -o reference.pdb
```
If you used straight up the `md.tpr` file of the Rec with GRK1, plumed will return an error and prompt the message 
```
pdb file named reference.pdb contains 5 chains 
```
Based on the subdivision made by gromacs and visible in `topol.top` in the folder `nmRec_Ca_GRK1`, you can see the five groups: 
1. `Protein`: resids 2-202, the recoverin
2. `Ion2`: ids 301-302, the two calcium ions
3. `Other3`: ids 8863-8974, potassium, clorine and magnesium ions
4. `Protein_chain_G`: resids 1-16, GRK1 peptide
5. `SOL`: solvent 

If you see the `reference.pdb` return by `gmx`, notice that the ions are all labeled with the chain id `B`, in fact, the ions are numbered with `B8863-B8974` (the `B` is attached because `editconf` is not designed to be a human-friendly command).

In the case of the recoverine alone, gromacs managed to put together the `CAL` residue with the rest of the protein. This time is slightly different. To solve the issue I simply named `D` the chain of the two calcium ions.

## Get the stats from gnuplot
```
gnuplot >> stats "DIST" u 2
```
Again, we obtain a very similar $\sigma=0.0066$ nm. 

