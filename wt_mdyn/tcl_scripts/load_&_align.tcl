
# Load reference structure
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/CM_Meta/nmRec_1/reference.pdb
# Load trajectory
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/CM_Meta/nmRec_1/traj_comp.xtc type xtc waitfor all

set nf [molinfo top get numframes]
set all [atomselect top "all"]
set ref_0 [atomselect top "protein and name CA" frame 0]
set ref [atomselect top "protein and name CA"]
for {set f 0 } {$f < $nf} {incr f} {
    $ref frame $f
    $all frame $f
    set M [measure fit $ref $ref_0]
    $all move $M
}