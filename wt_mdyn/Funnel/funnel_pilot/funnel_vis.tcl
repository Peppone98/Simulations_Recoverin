# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/funnel_pilot/ref_nowat.pdb type pdb waitfor all
set molID1 [molinfo top get id]
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/funnel_pilot/trj_fit.xtc type xtc waitfor all

# REPRESENTATION OF THE PROTEIN
mol top $molID1

# Represent the protein
mol representation NewCartoon 
mol color ColorID 6 
mol selection "protein" 
mol material BrushedMetal 
mol addrep top 

# Now I highlight the six coordinant oxygens
mol representation VDW 
mol color ColorID 1 
mol selection "index 1174 or index 1195 or index 1221 or index 1244 or index 1329 or index 1330"
mol material Opaque 
mol addrep top 

# Calcium ion representation
mol representation VDW 
mol color ColorID 4 
mol selection "resid 301 and resname CAL" 
mol material Opaque 
mol addrep top 

# Water molecules 
mol representation licorice
mol selection "same fragment as water and within 3 of (resid 301 and resname CAL)"
mol color name
mol material Opaque
mol addrep top

# residues of the pocket 
mol representation licorice
mol selection "protein and noh and resid 70 73 74 75 76 77 78 79 80 81 82 84 85"
mol color name
mol material Opaque
mol addrep top

# Define the atom index you are interested in
set atomIndex 3261  ;# Change this to the index of the atom you want to track

# Get the number of frames in the trajectory
set numFrames [molinfo $molID1 get numframes]

# Create a new representation for the spheres
# Add a new representation for spheres
graphics $molID1 color yellow
graphics $molID1 material Opaque

# Loop through all frames and get the positions of the atom
for {set i 0} {$i < $numFrames} {incr i} {
    # Go to the i-th frame
    animate goto $i

    # Get the coordinates of the atom
    set pos [atomselect $molID1 "index $atomIndex" frame $i]
    set coords [$pos get {x y z}]

    # Ensure coordinates are in the correct format
    set x [lindex $coords 0]
    set y [lindex $coords 1]
    set z [lindex $coords 2]

    # Draw a sphere at the atom's position
    graphics $molID1 sphere "$x $y $z" radius 0.5 resolution 20

    # Clean up
    $pos delete
}

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
# axes location Off
# axes drawn no

# Update the display to apply the changes
display update

# Plot box
pbc box

# Display the visualization
display resetview

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/funnel_head.png

