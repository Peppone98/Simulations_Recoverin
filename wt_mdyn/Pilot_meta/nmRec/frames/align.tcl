
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Pilot_meta/nmRec/frames/config/ref_0_whole.gro
mol new /Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Pilot_meta/nmRec/frames/config/ref_4_whole.gro type gro waitfor all


# Be careful: this must be run just after VMD is opened
set crystal [atomselect 0 "all"]
set atomsel1 [atomselect 0 "protein and name CA"]
set atomsel2 [atomselect 1 "protein and name CA"]
set M [measure fit $atomsel1 $atomsel2]

# Attenzione, qua muoviamo la prima struttura!
$crystal move $M