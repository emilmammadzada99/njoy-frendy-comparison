input_folder = '/path/gnuplot/comp_out';
output_folder_main = 'ace_plot';
output_folder_only = 'ace_plot_only';

% Create output directories if they do not exist
if ~exist(output_folder_main, 'dir')
    mkdir(output_folder_main);
end
if ~exist(output_folder_only, 'dir')
    mkdir(output_folder_only);
end

% Get list of .dat files
files = dir(fullfile(input_folder, '*.dat'));

for k = 1:length(files)
    filepath = fullfile(input_folder, files(k).name);
    disp(['Processing: ', filepath]);
    
    % Get file name without extension
    [~, filename_no_ext, ~] = fileparts(files(k).name);
    
    % Load the data
    data = load(filepath);
    
    % Columns:
    % 1 - Energy (eV)
    % 2 - NJOY XS
    % 3 - FRENDY XS
    % 4 - Relative difference (FRENDY - NJOY) / NJOY
    
    energy = data(:,1);
    xs_njoy = data(:,2);
    xs_frendy = data(:,3);
    xs_diff = data(:,4) * 100.0;  % convert to percentage
    
    % Main figure with dual Y axes
    fig1 = figure('Visible', 'off', 'Position', [100, 100, 1920, 1440]);
    
    [ax, h1, h2] = plotyy(energy, xs_njoy, energy, xs_diff, @loglog, @semilogx);
    hold(ax(1), 'on');
    loglog(ax(1), energy, xs_frendy, 'r--', 'LineWidth', 2);  % Add FRENDY on left axis
    
    % Format lines
    set(h1, 'LineWidth', 2, 'Color', 'b'); % NJOY
    set(h2, 'LineWidth', 2, 'Color', 'k', 'LineStyle', '-.'); % Difference
    set(ax(1), 'XScale', 'log');
    set(ax(2), 'XScale', 'log');
    set(ax(2), 'YLim', [-1 1]);
    
    % Labels and styling
    ylabel(ax(1), 'Cross Section [barn]');
    ylabel(ax(2), '(FRENDY - NJOY) / NJOY [%]');
    xlabel(ax(1), 'Neutron Energy [eV]');
    title(filename_no_ext, 'Interpreter', 'none');
    legend(ax(1), {'NJOY', 'FRENDY'}, 'Location', 'southwest');
    legend(ax(2), 'Difference', 'Location', 'northeast');
    grid on;
    set(gca, 'FontSize', 18);
    xlim(ax(1), [1e-5, 2e7]);
    xlim(ax(2), [1e-5, 2e7]);
    
    % Save main figure
    saveas(fig1, fullfile(output_folder_main, [filename_no_ext, '_xs.png']));
    close(fig1);

    % XS-only plot (left axis only)
    fig2 = figure('Visible', 'off', 'Position', [100, 100, 1920, 1440]);
    loglog(energy, xs_njoy, 'b-', 'LineWidth', 2); hold on;
    loglog(energy, xs_frendy, 'r--', 'LineWidth', 2);
    xlabel('Neutron Energy [eV]');
    ylabel('Cross Section [barn]');
    title([filename_no_ext, ' (XS only)'], 'Interpreter', 'none');
    legend('NJOY', 'FRENDY', 'Location', 'southwest');
    xlim([1e-5, 2e7]);
    grid on;
    set(gca, 'FontSize', 18);
    
    % Save XS-only plot
    saveas(fig2, fullfile(output_folder_only, [filename_no_ext, '_xs_only.png']));
    close(fig2);
end

disp('All plots have been successfully generated.');

