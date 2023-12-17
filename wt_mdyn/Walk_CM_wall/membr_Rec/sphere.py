
import MDAnalysis as mda
import nglview as nv

# Function to calculate the center of mass (CM)
def calculate_center_of_mass(universe):
    protein = universe.select_atoms('protein')
    cm = protein.center_of_mass()
    return cm

# Load the protein structure using MDAnalysis
pdb_file = 'ref_1.pdb'
universe = mda.Universe(pdb_file)

# Calculate the center of mass (CM) of the protein
cm = calculate_center_of_mass(universe)

# Create an NGLView object
view = nv.show_mdanalysis(universe)

# Add a transparent sphere centered around the center of mass (CM)
radius = 10.0  # Adjust the radius as needed
view.shape.add('surface', center=list(cm), radius=radius, color='transparent')

# Display the NGLView
view.representations = []
view.add_representation('cartoon', selection='protein', color='sstruc')
view.center()
view.display()
