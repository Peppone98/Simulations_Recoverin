# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/funnel/mRec_EF3/ANALYSIS/nowat.gro type gro waitfor all
set molID1 [molinfo top get id]

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
mol selection "index 1215 or index 1236 or index 1262 or index 1285 or index 1370 or index 1371"
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

# Calcium ion in EF3
mol representation VDW
mol color ColorID 1
mol selection "index 1800 or index 1799 or index 1844 or index 1923 or index 1922 or index 1771"
mol material Opaque
mol addrep top

mol representation VDW
mol color ColorID 4
mol selection "resid 302 and resname CAL"
mol material Opaque
mol addrep top

# residues of the pocket 
mol representation licorice
mol selection "protein and noh and resid 106 110 111 112 113 114 115 116 117 118 120 121"
mol color name
mol material Opaque
mol addrep top
#r 106 | r 110 | r 111 | r 112 | r 113 | r 114 | r 115 | r 116 | r 117 | r 118 | r 120 | r 121


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

# Load the tool for plotting the funnel
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/tooltip.tcl
source /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/tooltip/funnel.tcl
funnel_tk