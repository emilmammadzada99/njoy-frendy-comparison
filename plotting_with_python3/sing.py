import os
import numpy as np
import matplotlib.pyplot as plt

# Input and output directories
input_folder = '/home/emil/compnjfr_copy/gnuplot/single_out'
output_folder = './plot'

# Create output folder if it does not exist
os.makedirs(output_folder, exist_ok=True)

# Get list of all .dat files in input folder
files = [f for f in os.listdir(input_folder) if f.endswith('.dat')]
print(f"Found {len(files)} data files in {input_folder}")

# Plot limits
xmin = 1.0e-5
xmax = 2.0e7

for file in files:
    filepath = os.path.join(input_folder, file)
    name_no_ext = os.path.splitext(file)[0]
    print(f"Processing: {filepath}")

    # Load data assuming 2 columns: energy and cross section
    data = np.loadtxt(filepath)
    energy = data[:, 0]
    xs = data[:, 1]

    # Create a figure
    fig, ax = plt.subplots(figsize=(19.2, 14.4), dpi=100)

    # Log-log plot
    ax.loglog(energy, xs, linewidth=6)

    # Grid and limits
    ax.grid(True, which="both", ls="--")
    ax.set_xlim([xmin, xmax])

    # Labels and title
    ax.set_xlabel('Neutron Energy [eV]', fontsize=36, fontname='Liberation Serif')
    ax.set_ylabel('Cross Section [barn]', fontsize=36, fontname='Liberation Serif')
    ax.set_title(name_no_ext, fontsize=48, fontname='Liberation Serif')

    # Set tick parameters
    ax.tick_params(axis='both', which='major', labelsize=28, width=4)

    # Set border line width
    for spine in ax.spines.values():
        spine.set_linewidth(4)

    # Save as PNG
    output_path = os.path.join(output_folder, f"{name_no_ext}_xs.png")
    fig.savefig(output_path, bbox_inches='tight', dpi=150)
    plt.close(fig)

print("All plots generated successfully.")

