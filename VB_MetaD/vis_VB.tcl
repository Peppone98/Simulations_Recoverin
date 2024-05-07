# Load topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/VB_MetaD/ref.pdb type pdb waitfor all
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

# Calculate the center of mass of the protein
set sel [atomselect top "protein and noh and resid 74 76 78 80 85"]
set cm [measure center $sel weight mass]

# Define the radius of the sphere (you can adjust this value as needed)
set radius 30.0

# Create a VMD graphical representation of the sphere
set mol [molinfo top get id]
graphics $mol color green
graphics $mol sphere $cm radius $radius resolution 100
graphics $mol material Transparent


# Update the display to apply the changes
display update

# Plot box
pbc box

# Display the visualization
display resetview

#render TachyonInternal /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/nmRec/funnel_head.png


