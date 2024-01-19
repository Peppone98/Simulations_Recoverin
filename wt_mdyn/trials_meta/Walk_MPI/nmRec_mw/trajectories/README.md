
# TCL Language 

The rule is: when you get multiple atom attributes (in this case, x,
y, and z), the result is always returned as a nested list, even if that
list contains only one element.
```
set oneCoord [$oneAtom get {x y z}] ;# returns something like {{1 2 3}}
```
So, you should take each component separately. Alternatively, you should always use 
```
set pos [lindex [$sel get {x y z}] 0]
```

# Problem of removing PBC effects
The idea is to create a new `.tpr` file in which the solvent is excluded. How can we do this? We move in the `tpr_generation` folder in which all the force fields/topologies etc are present and do 
```
gmx grompp -f mdp/md.mdp -c ref_nowat.gro -p topol_nowat.top -o nowat.tpr
```
not that we created the new topology `topol_nowat.top` by simply removing the `SOL` molecules. After this, we place ourself again in the current folder and type
```
gmx trjconv -s nowat.tpr -f traj_nowat_0.xtc -o traj_nowat_nojump.xtc -pbc nojump -center -n index
```
select `Protein` for centering and `System` for output. 

The `-pbc nojump` option removes jumps caused by periodic boundary conditions. This ensures that the trajectory is continuous and does not have artificial jumps when atoms cross simulation box boundaries.