
# Set the reference structure
set reference_structure "/Users/giuseppegambini/Desktop/TESI/simulations/wt_mdyn/Funnel/funnel_pilot/ref_nowat.pdb"

# Load the reference structure
mol new $reference_structure
set reference_structure_CA [atomselect top "protein and name CA"]

# Represent the protein
mol representation NewCartoon
mol color ColorID 0
mol selection "protein"
mol material Opaque
mol addrep top

# Calcium ion representation
mol representation VDW
mol color ColorID 4
mol selection "resid 301 and name CAL"
mol material Opaque
mol addrep top

# Now I highlight the six coordinant oxygens
mol representation VDW
mol color ColorID 1
mol selection "index 1175 or index 1196 or index 1222 or index 1245 or index 1330 or index 1331"
mol material Opaque
mol addrep top



    