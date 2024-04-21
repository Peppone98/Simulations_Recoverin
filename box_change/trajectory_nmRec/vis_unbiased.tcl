# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/box_change/trajectory_nmRec/ref_editconf.pdb type pdb waitfor all
set molID1 [molinfo top get id]
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/box_change/trajectory_nmRec/trj_center.xtc type xtc step 1 filebonds 1 autobonds 1 waitfor all


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

# residues of the six Oxygens 
mol representation licorice
mol selection "protein and noh and resid 74 76 78 80 85"
mol color name
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

# Display the visualization
display resetview

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/funnel_head.png


