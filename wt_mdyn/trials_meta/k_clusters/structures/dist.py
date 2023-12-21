import MDAnalysis as mda

def compute_center_of_mass(pdb_file, selection):
    # Load the PDB file
    u = mda.Universe(pdb_file)

    # Select the atoms of interest
    group_atoms = u.select_atoms(selection)

    # Compute the center of mass
    com = group_atoms.center_of_mass()

    return com

def compute_distance_between_centers_of_mass(pdb_file, selection1, selection2):
    # Compute the center of mass for each selection
    com_selection1 = compute_center_of_mass(pdb_file, selection1)
    com_selection2 = compute_center_of_mass(pdb_file, selection2)

    # Compute the distance between the centers of mass
    distance = mda.lib.distances.distance_array(com_selection1, com_selection2)[0]

    return distance

if __name__ == "__main__":
    # Specify the PDB file and the selection strings
    file_path = "ref_1.gro"
    
    # Replace 'protein' and 'ligand' with your specific atom selections
    selection1 = 'index 1215 or index 1236 or index 1262 or index 1285 or index 1370 or index 1371'
    selection2 = 'index 3302'

    #selection1 = 'index 0'
    #selection2 = 'index 1'

    # Compute and print the distance between the centers of mass
    distance = compute_distance_between_centers_of_mass(file_path, selection1, selection2)
    print(f"Distance between the centers of mass of selections '{selection1}' and '{selection2}': {distance} Angstroms")

    com1 = compute_center_of_mass(file_path, selection1)
    print(f"Centers of mass of selection '{selection1}': {com1} Angstroms")

    com2 = compute_center_of_mass(file_path, selection2)
    print(f"Centers of mass of selection '{selection2}': {com2} Angstroms")


