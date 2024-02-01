
# Set the reference structure
mol new "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec_MW_funnel/WALKER2/ref_nowat2.pdb" type pdb waitfor all
mol addfile "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec_MW_funnel/WALKER2/trj_fit.xtc" type xtc step 1 filebonds 1 autobonds 1 waitfor all

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


    