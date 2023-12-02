
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/traj_nowat_0.xtc type xtc first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/ref_nowat.gro type gro waitfor all

# Specify the atom selection 
set sel [atomselect top "resid 301"]

# Get the number of frames in the trajectory
set numFrames [molinfo top get numframes]

# Loop over frames and create a representation for each frame
for {set frame 0} {$frame < $numFrames} {incr frame} {
    $sel frame $frame

    # Get the position of the selected atom
    set position [$sel get {x y z}]

    # Create a representation for the atom at its position
    draw color red
    draw sphere $position radius 0.3
}

# Display the visualization
display resetview

#This script iterates through each frame in the trajectory, 
#sets the frame for the atom selection, and creates a representation 
# (a red sphere in this case) at the atom's position for that frame. 
#The display resetview command ensures that the visualization is properly oriented.