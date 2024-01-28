
# Set the reference structure
set reference_structure "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/funnel_pilot/frames_fit/frame_12580.pdb"

# Load the reference structure
mol new $reference_structure
set reference_structure_CA [atomselect top "protein and name CA"]

# Represent the protein
mol representation NewCartoon
mol color ColorID 0
mol selection "protein"
mol material Opaque
mol addrep top

# Calcium ion representation
mol representation VDW
mol color ColorID 4
mol selection "resid 301 and name CAL"
mol material Opaque
mol addrep top

# List of frame files to align
set frame_files {"/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/funnel_pilot/frames_center/frame_12580.pdb" }

# Loop through each frame and align to the reference structure
foreach frame_file $frame_files {

    # Load the current frame
    mol new $frame_file type pdb waitfor all
    set to_be_moved [atomselect top "all"]
    set current_frame [atomselect top "protein and name CA"]

    # Perform least-squares fitting to align the current frame to the reference structure
    set M [measure fit $current_frame $reference_structure_CA]

    # Perform the alignment
    puts $M

    # Represent the protein
    mol representation NewCartoon
    mol color ColorID 0
    mol selection "protein"
    mol material Opaque
    mol addrep top

    # Calcium ion representation
    mol representation VDW
    mol color ColorID 4
    mol selection "resid 301 and name CAL"
    mol material Opaque
    mol addrep top

    # Now I highlight the six coordinant oxygens
    mol representation VDW
    mol color ColorID 1
    mol selection "index 1175 or index 1196 or index 1222 or index 1245 or index 1330 or index 1331"
    mol material Opaque
    mol addrep top
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

# Update the display to apply the changes
display update

# Plot box
pbc box

# Display the visualization
display resetview

# Load the tool for plotting the funnel
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/tooltip.tcl
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/funnel.tcl
funnel_tk


    