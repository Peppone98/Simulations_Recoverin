# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/multisite_Ca2+/nmRec/volume_based/states/bound.gro type gro waitfor all
set molID1 [molinfo top get id]

mol new /Users/giuseppegambini/Desktop/TESI/simulations/multisite_Ca2+/nmRec/volume_based/states/unbound.gro type gro waitfor all
set molID2 [molinfo top get id]


# REPRESENTATION OF THE PROTEIN
mol top $molID1

# Represent the protein
mol representation NewCartoon 
mol color ColorID 0 
mol selection "protein" 
mol material Opaque 
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
mol selection "resid 377 and resname CAM" 
mol material Opaque 
mol addrep top 

# Represent the second protein
mol top $molID2 
mol representation NewCartoon 
mol color ColorID 0 
mol selection "protein" 
mol material Opaque 
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
mol selection "resid 377 and resname CAM" 
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
