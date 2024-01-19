
# Load trajectory and topology
load ref_nowat.gro, top
load_traj nowat.xtc, traj

# Specify the atom selection (replace 'name CA' with the atom name you are interested in)
atom_selection = "resid 301"

# Iterate through frames in the trajectory
# Set the frame
# Get the position of the selected atom
# Draw a sphere at the atom position
# Connect the consecutive positions with a line
num_frames = cmd.count_states("traj")

for frame in range(1, num_frames + 1):
    
    cmd.frame(frame)

    position = cmd.get_model(atom_selection).get_coord_list()[0]

    cmd.pseudoatom("sphere_" + str(frame), pos=position, color="red")

    if frame > 1:
        prev_position = cmd.get_model(atom_selection, state=frame-1).get_coord_list()[0]
        cmd.load_cgo([SPHERE] + prev_position + position + [LINEWIDTH, 2.0, COLOR, 0.0, 0.0, 1.0], "line_" + str(frame))

# Center the view
cmd.center("all")

# Show the visualization
cmd.show("sticks")
