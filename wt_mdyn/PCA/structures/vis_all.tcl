

# Specify the list of PDB files
set pdb_files {"/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/PCA/structures/ref_0.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/PCA/structures/ref_1.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/PCA/structures/ref_2.pdb" "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/PCA/structures/ref_3.pdb"}

# Loop through each PDB file
foreach pdb_file $pdb_files {
    # Load PDB file
    mol new $pdb_file

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

    # Highlight the pocket 
    mol representation NewCartoon
    mol color ColorID 7
    mol selection "resid 72 to 87"
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

# Center the view on the first molecule
display resetview

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/membr_Rec/funnel.png

# Load the tool for plotting the funnel
#source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/tooltip.tcl
#source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/funnel.tcl
#funnel_tk


