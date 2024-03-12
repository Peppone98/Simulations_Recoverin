
package require topotools 1.5

# Load your trajectory and topology
set mol [mol new /Users/giuseppegambini/Desktop/TESI/simulations/multisite_Ca2+/membr_Rec/membr_Rec.pdb type pdb waitfor all]
# do the magic
set newmol [::TopoTools::replicatemol $mol 2 2 1 ]
animate write gro periodic.gro $newmol

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
#mol representation NewCartoon
#mol color ColorID 7
#mol selection "resid 73 to 86"
#mol material Opaque
#mol addrep top

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


