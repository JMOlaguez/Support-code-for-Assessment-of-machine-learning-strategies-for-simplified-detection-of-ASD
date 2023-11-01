% Specify the file name and sheet name
file = 'DAN_ETIQUETADA.xlsx';
sheet = 1;  % Data is on the first sheet
data = xlsread(file, sheet); % Import data from the Excel file

% Extract headers (bacteria names) and diagnosis
headers = data(1, 2:end); % The first row contains headers
diagnosis = data(2:end, 1); % The firs column contains diagnosis

% Data matrix without headers and diagnosis
data = data(2:end, 2:end);

% Calculate the correlation matrix
correlation_matrix = corr(data);

% Set the correlation threshold for color
threshold = 0.3;

% Create a heatmap with red color for correlations > 0.3
cmap = jet(256); % Colormap selection
cmap(end, :) = [1, 0, 0]; % Set the last color in the colormap to red

heatmap(correlation_matrix, 'Colormap', cmap);

% Add a color bar
%colorbar;

% 1. Total number of elements in the correlation matrix
total_elements = numel(correlation_matrix)-356;

% 2. Number of elements greater than 0.35
elements_above_threshold = sum(correlation_matrix(:) > 0.3)-356;

% 3. Create a pie chart to show the information
figure;
pie_data = [elements_above_threshold, total_elements - elements_above_threshold];
labels = {'> 0.3', '<= 0.3'};
pie(pie_data, labels);

% Add a title to the pie chart
title('Correlation Matrix Element Distribution');

% Display the counts
disp(['Total number of elements in the correlation matrix (after removing diagonal elements): ' num2str(total_elements)]);
disp(['Number of elements greater than 0.3 (after removing diagonal elements): ' num2str(elements_above_threshold)]);

% Calculate the percentages
percentage_above  = (elements_above_threshold / total_elements) * 100;
percentage_below_or_equal = 100 - percentage_above;

% Display the percentages
disp(['Total number of elements in the correlation matrix (after removing diagonal elements): ' num2str(total_elements)]);
disp(['Number of elements above 0.3 (after removing diagonal elements): ' num2str(elements_above_threshold)]);
disp(['Percentage of elements below or equal to 0.3 (after removing diagonal elements): ' num2str(percentage_below_or_equal) ' %']);
disp(['Percentage of elements above 0.3 (after removing diagonal elements): ' num2str(percentage_above) ' %']);