
# Load your trajectory and topology
#mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/traj_nowat_0.xtc type xtc first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
#mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/ref_nowat.gro type gro waitfor all

# Specify the atom selection (replace 'name CA' with the atom name you are interested in)
set sel [atomselect top "resid 301"]

# Get the number of frames in the trajectory
set numFrames [molinfo top get numframes]

for {set frame 0} {$frame < $numFrames} {incr frame} {
    $sel frame $frame

    # Get the position of the selected atom
    set position [$sel get {x y z}]

    # Connect the consecutive positions with a line
    if {$frame > 0} {
        set prev_position [$sel get {x y z} frame [expr $frame - 1]]
        draw color red
        draw line $prev_position $position
    }
}