import os
import numpy as np
import matplotlib.pyplot as plt

# Input and output folders
input_folder = '/home/emil/compnjfr_copy/gnuplot/comp_out'
output_folder_main = 'ace_plot'
output_folder_only = 'ace_plot_only'

# Create output directories if not exist
os.makedirs(output_folder_main, exist_ok=True)
os.makedirs(output_folder_only, exist_ok=True)

# Get list of .dat files
files = [f for f in os.listdir(input_folder) if f.endswith('.dat')]

for file in files:
    filepath = os.path.join(input_folder, file)
    filename_no_ext = os.path.splitext(file)[0]
    print(f"Processing: {filepath}")

    # Load data (4 columns expected)
    data = np.loadtxt(filepath)
    energy = data[:, 0]
    xs_njoy = data[:, 1]
    xs_frendy = data[:, 2]
    xs_diff = data[:, 3] * 100.0  # convert to percentage

    # --- Main figure with dual y-axis ---
    fig, ax1 = plt.subplots(figsize=(19.2, 14.4), dpi=100)

    # First axis: log-log plot for NJOY and FRENDY
    ln1 = ax1.loglog(energy, xs_njoy, 'b-', linewidth=2, label='NJOY')[0]
    ln2 = ax1.loglog(energy, xs_frendy, 'r--', linewidth=2, label='FRENDY')[0]
    ax1.set_xlabel('Neutron Energy [eV]')
    ax1.set_ylabel('Cross Section [barn]')
    ax1.set_xlim([1e-5, 2e7])
    ax1.grid(True, which='both')
    ax1.tick_params(labelsize=18)

    # Second axis: semilogx for relative difference
    ax2 = ax1.twinx()
    ln3 = ax2.semilogx(energy, xs_diff, 'k-.', linewidth=2, label='Difference')
    ax2.set_ylabel('(FRENDY - NJOY) / NJOY [%]')
    ax2.set_ylim([-1, 1])
    ax2.tick_params(labelsize=18)

    # Title and legends
    fig.suptitle(filename_no_ext, fontsize=22)
    ax1.legend(handles=[ln1, ln2], loc='lower left')
    ax2.legend([ln3], loc='upper right')

    # Save the main figure
    fig.tight_layout(rect=[0, 0, 1, 0.95])  # Leave space for title
    fig.savefig(os.path.join(output_folder_main, f"{filename_no_ext}_xs.png"))
    plt.close(fig)

    # --- XS-only figure ---
    fig2, ax = plt.subplots(figsize=(19.2, 14.4), dpi=100)
    ax.loglog(energy, xs_njoy, 'b-', linewidth=2, label='NJOY')
    ax.loglog(energy, xs_frendy, 'r--', linewidth=2, label='FRENDY')
    ax.set_xlabel('Neutron Energy [eV]')
    ax.set_ylabel('Cross Section [barn]')
    ax.set_xlim([1e-5, 2e7])
    ax.set_title(f'{filename_no_ext} (XS only)', fontsize=22)
    ax.grid(True, which='both')
    ax.tick_params(labelsize=18)
    ax.legend(loc='lower left')

    # Save the XS-only figure
    fig2.tight_layout()
    fig2.savefig(os.path.join(output_folder_only, f"{filename_no_ext}_xs_only.png"))
    plt.close(fig2)

print("All plots have been successfully generated.")

