# Set the terminal and output file type
set terminal png
set output 'surface_plot_BIAS.png'

# Set the title and labels
set title 'Surface Plot'
set xlabel 'X-axis'
set ylabel 'Y-axis'
set zlabel 'Z-axis'

# Enable 3D plotting
set pm3d

# Specify the file and columns
file_path = 'BIAS'
plot file_path using 1:2:3 with lines notitle