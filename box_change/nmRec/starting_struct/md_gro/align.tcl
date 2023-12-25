
# Set the reference structure
set reference_structure "/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_0_whole.gro"

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
set frame_files {"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_1_whole.gro" 
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_2_whole.gro" 
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_3_whole.gro"
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_4_whole.gro"
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_5_whole.gro"
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_6_whole.gro"
"/Users/giuseppegambini/Desktop/TESI/simulations/box_change/nmRec/starting_struct/md_gro/md_7_whole.gro"}

# Loop through each frame and align to the reference structure
foreach frame_file $frame_files {

    # Load the current frame
    mol new $frame_file type gro waitfor all
    set to_be_moved [atomselect top "all"]
    set current_frame [atomselect top "protein and name CA"]

    # Perform least-squares fitting to align the current frame to the reference structure
    set M [measure fit $current_frame $reference_structure_CA]

    # Perform the alignment
    $to_be_moved move $M

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
}

# Set up visualization settings
display depthcue off
display rendermode GLSL
display ambientocclusion on
display antialias on
display projection Orthographic
display nearclip set 0.1
display update

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


    