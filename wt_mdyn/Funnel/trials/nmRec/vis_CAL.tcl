
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/md_nowat_fit.xtc type xtc first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/npt_nowat.gro type gro waitfor all

# Get the number of frames in the trajectory
set numFrames [molinfo top get numframes]

# Specify the atom selection 
set sel [atomselect top "resid 301"]

# Loop over frames and create a representation for each frame
for {set frame 0} {$frame < $numFrames} {incr frame} {
    $sel frame $frame

    # Get the position of the selected atom
    set position [lindex [$sel get {x y z}] 0]

    # Create a representation for the atom at its position
    draw color green
    draw sphere $position radius 0.3
}

# Display the visualization
display resetview

#This script iterates through each frame in the trajectory, 
#sets the frame for the atom selection, and creates a representation 
# (a red sphere in this case) at the atom's position for that frame. 
#The display resetview command ensures that the visualization is properly oriented.


# Create a representation for the protein
# You can adjust the representation style based on your preferences
# For example, "NewCartoon" for cartoon representation
# For more representation styles, refer to the VMD documentation
mol representation NewCartoon
mol color ColorID 0
mol selection "protein"
mol material Opaque
mol addrep top

# Now I highlight the six coordinant oxygens
mol representation Licorice
mol color ColorID 1
mol selection "index 1175 or index 1196 or index 1222 or index 1245 or index 1330 or index 1331"
mol material Opaque
mol addrep top

# Set up visualization settings
display depthcue off
display rendermode GLSL
display ambientocclusion on
display antialias on
display projection Orthographic
display nearclip set 0.1
display update

# Set the background color (optional)
color Display Background white

# Hide the coordinate axes
axes location Off
axes drawn no

# Update the display to apply the changes
display update

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/funnel_head.png