
# Load your trajectory and topology
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/CM_Meta/membr_Rec/npt_nowat.gro type gro waitfor all
mol addfile /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/CM_Meta/membr_Rec/md_nowat_nojump.xtc type xtc step 1 filebonds 1 autobonds 1 waitfor all


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
mol selection "index 1175 or index 1196 or index 1222 or index 1245 or index 1330 or index 1331"
mol material Opaque
mol addrep top

# Calcium ion representation
mol representation VDW
mol color ColorID 4
mol selection "resid 301 and name CAL"
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

# COMPUTE THE CM DISTANCE

set sel1 [atomselect top "protein"]
set sel2 [atomselect top "resid 301 and resname CAL"]

# Get the number of frames in the trajectory
set nf [molinfo top get numframes]

# Open the output file for writing
set outfile [open /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/CM_Meta/membr_Rec/dist_out.dat w]

for {set f 0} {$f < $nf} {incr f} {
    $sel1 frame $f
    $sel2 frame $f
    set com1 [measure center $sel1 weight mass]

    # Draw points for the CM of the protein
    draw color red
    draw sphere $com1 radius 0.3

    set com2 [measure center $sel2 weight mass]

    # Draw positions of CAL
    draw color green
    draw sphere $com2 radius 0.3

    set distance [veclength [vecsub $com1 $com2]]
    puts $outfile $f\t$distance
}

close $outfile


