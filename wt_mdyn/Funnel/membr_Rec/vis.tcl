
# Load your trajectory and topology

# Specify the list of PDB files
set pdb_files {"/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_1_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_2_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_3_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_4_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_5_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_6_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_7_aligned.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/eight_config/ref_8_aligned.pdb"}

# Loop through each PDB file
foreach pdb_file $pdb_files {
    # Load PDB file
    mol new $pdb_file type pdb waitfor all

    # REPRESENTATION OF THE PROTEIN

    # Represent the protein
    mol representation NewCartoon
    mol color ColorID 0
    mol selection "protein"
    mol material Opaque
    mol addrep top

    # Now I highlight the six coordinant oxygens
    mol representation VDW
    mol color ColorID 1
    mol selection "index 1216 or index 1237 or index 1263 or index 1286 or index 1371 or index 1372"
    mol material Opaque
    mol addrep top

    # Calcium ion representation
    mol representation VDW
    mol color ColorID 4
    mol selection "resid 301 and name CAL"
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
    # axes location Off
    # axes drawn no

    # Update the display to apply the changes
    display update

    # Plot box
    pbc box

    
}

# Display the visualization
display resetview

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/funnel.png

# Load the tool for plotting the funnel
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/tooltip.tcl
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/funnel.tcl
funnel_tk


