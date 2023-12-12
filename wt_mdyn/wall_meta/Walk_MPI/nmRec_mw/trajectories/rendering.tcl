
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/traj_nowat_0.xtc type xtc first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/ref_nowat.gro type gro waitfor all

# Create a representation for the protein
# You can adjust the representation style based on your preferences
# For example, "NewCartoon" for cartoon representation
# For more representation styles, refer to the VMD documentation
mol representation NewCartoon
mol color ColorID 0
mol selection "protein"
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

# Adjust the view
rotate x by 30
rotate y by 45

# Save the rendered image (adjust the filename and format as needed)
render TachyonInternal your_rendered_image.png

# Exit VMD (optional, comment out if you want to keep VMD open)
#quit
