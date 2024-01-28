#!/bin/bash

n_walk=(0 1 2 3 4 5 6 7)

len=${#n_walk[@]}

for (( i=0; i<$len; i++ ))
do
    # Original PDB file
    original_pdb=frames_center/frame_${n_walk[i]}.pdb

    # New PDB file
    #CA_pdb=pdb/ref_CA_${n_walk[i]}.pdb

    # Atom name to filter (e.g., "CA")
    #atom_name="CA"

    # Filter lines containing the specified atom name and save them to the new PDB file
    #grep -w "$atom_name" "$original_pdb" | awk '$1 == "ATOM" || $1 == "HETATM"' > "$CA_pdb"

    #echo "Created PDB with alpha-Carbons: $CA_pdb"

    # New PDB file
    pocket_pdb=pdb/pocket_${n_walk[i]}.pdb

    # Filter lines corresponding to residues 70-90 using awk and save them to the new PDB file
    awk '($1 == "ATOM" || $1 == "HETATM") && $6 >= 70 && $6 <= 90 { print }' "$original_pdb" > "$pocket_pdb"

    echo "Created PDB with pocket residues: $pocket_pdb"
done

# La parte della pocket sembra non funzionare. Forse a questo punto conviene
# elencare direttamente i nomi dei residui e buonanotte. 




