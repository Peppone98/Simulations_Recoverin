
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/pbc_nowat_0.xtc type xtc first 0 last -1 step 1 filebonds 1 autobonds 1 waitfor all
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/ref_nowat.gro type gro waitfor all

# Specify the atom selection 
set sel [atomselect top "resid 301"]

# Get the number of frames in the trajectory
set numFrames [molinfo top get numframes]

# Open a file to write atom positions
set outfile [open "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Walk_MPI/nmRec_mw/trajectories/CAL_positions.dat" w]

# Loop over frames and write the position of the selected atom to the file
for {set frame 0} {$frame < $numFrames} {incr frame} {
    $sel frame $frame
    set position [$sel get {x y z}]
    puts $outfile "$frame $position"
}

# Close the trajectory and the output file
$sel delete
mol delete top
close $outfile