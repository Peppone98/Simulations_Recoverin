
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/box_change/membr_Rec/new_membr_Rec.pdb type pdb waitfor all

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
mol selection "index 23532 or index 23553 or index 23579 or index 23602 or index 23687 or index 23688"
mol material Opaque
mol addrep top

# Calcium ion representation
mol representation VDW
mol color ColorID 4
mol selection "resid 301 and name CAL"
mol material Opaque
mol addrep top

# Highlight the pocket 
mol representation licorice
mol color name
mol selection "protein and resid 70 73 74 75 76 77 78 79 80 81 82 84 85"
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


