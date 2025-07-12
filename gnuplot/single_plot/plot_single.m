% Octave script for plotting cross section data from .dat files
% Replaces previous csh + gnuplot script with Octave native plotting

input_folder = '/home/emil/compnjfr_copy/gnuplot/single_out';  % Absolute path to input folder
output_folder = './plot';  % Output folder for plots

% Create output folder if it does not exist
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

% Get list of all .dat files in input folder
files = dir(fullfile(input_folder, '*.dat'));
disp(['Found ', num2str(length(files)), ' data files in ', input_folder]);

% Plot limits for x-axis
xmin = 1.0e-5;
xmax = 2.0e7;

for k = 1:length(files)
    filename = fullfile(input_folder, files(k).name);
    [~, name_no_ext, ~] = fileparts(files(k).name);
    disp(['Processing: ', filename]);

    % Load data (assuming numeric, at least 2 columns: energy, xs)
    data = load(filename);
    energy = data(:,1);
    xs = data(:,2);

    % Create invisible figure with large size
    fig = figure('Visible', 'off', 'Position', [100, 100, 1920, 1440]);

    % Log-log plot of energy vs cross section with thick line
    loglog(energy, xs, 'LineWidth', 6);
    grid on;

    % Set x axis limits
    xlim([xmin xmax]);

    % Set labels with large font size and font family Liberation Serif
    xlabel('Neutron Energy [eV]', 'FontSize', 36, 'FontName', 'Liberation Serif');
    ylabel('Cross Section [barn]', 'FontSize', 36, 'FontName', 'Liberation Serif');

    % Set title with no interpreter for special characters, big font
    title(name_no_ext, 'Interpreter', 'none', 'FontSize', 48, 'FontName', 'Liberation Serif');

    % Get current axis
    ax = gca;

    % Octave does not support setting axis exponent format with dot notation,
    % so the following lines are commented out
    % ax.XAxis.Exponent = floor(log10(xmin));
    % ax.YAxis.Exponent = floor(log10(min(xs(xs>0))));

    % Set thick border line width and font size for ticks
    set(gca, 'LineWidth', 6, 'FontSize', 36);

    % Save figure as PNG with ~150 dpi resolution, large size
    set(gcf, 'PaperPositionMode', 'auto');
    print(fig, fullfile(output_folder, [name_no_ext, '_xs.png']), '-dpng', '-r150');

    % Close the figure to free memory
    close(fig);
end

disp('All plots generated successfully.');

