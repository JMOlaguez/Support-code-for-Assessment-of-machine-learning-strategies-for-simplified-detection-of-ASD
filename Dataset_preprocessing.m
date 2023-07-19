% The downloades dataset must be saved as  'Otus_and_abundance.xls'
% This program takes the downloaded dataset and puts it in a format ready to calculate the relative presences in terms of percentages
% Group A is refered to NT subjects and B group to ASD subjects
% It groups the OTUs into their common genus
% In order of this program to work as intended, MSExcel must be set in english 

input_file = 'Otus_and_abundance.xls';
converted_file = 'Otus_and_abundances_converted.xlsx';
[~, ~, raw] = xlsread(input_file);
xlswrite(converted_file, raw);
[~, ~, converted_data] = xlsread(converted_file);
column_labels = converted_data(1, 3:end);

group_a_indices = find(startsWith(string(column_labels), 'A'));
group_b_indices = find(startsWith(string(column_labels), 'B'));
ordered_columns = [1, 2, group_a_indices, group_b_indices+2];

ordered_data = cell(size(converted_data, 1), numel(ordered_columns));
for i = 1:numel(ordered_columns)
    ordered_data(:, i) = converted_data(:, ordered_columns(i));
end

output_file = 'Otus_and_abundances_ordered.xlsx';
writetable(cell2table(ordered_data), output_file, 'Sheet', 1, 'WriteVariableNames', false);
disp(group_b_indices);
disp(['The ordered file ''' output_file ''' has been created.']);

% Program 2
[~, ~, data] = xlsread(output_file);
sorted_data = sortrows(data, 2);
xlswrite(output_file, sorted_data);

% Program 3
[~, ~, data] = xlsread(output_file);
data(:, 2) = cellfun(@(x) strsplit(x, ';'), data(:, 2), 'UniformOutput', false);
data(:, 2) = cellfun(@(x) getSecondToLast(x), data(:, 2), 'UniformOutput', false);
data(:, 2) = cellfun(@(x) strsplit(x, '_g__'), data(:, 2), 'UniformOutput', false);
data(:, 2) = cellfun(@(x) x{end}, data(:, 2), 'UniformOutput', false);
writetable(cell2table(data), 'Otus_and_abundances_ordered_taxonomy.xlsx', 'Sheet', 1, 'WriteVariableNames', false);

% Program 4
[~, sheets] = xlsfinfo('Otus_and_abundances_ordered_taxonomy.xlsx');
[~, ~, data] = xlsread('Otus_and_abundances_ordered_taxonomy.xlsx', sheets{1});
max_row = size(data, 1);
current_name = data{2, 2};

for row = 3:max_row
    name = data{row, 2};
    
    if ~strcmp(name, current_name)
        data = [data(1:row-1, :); cell(1, size(data, 2)); data(row:end, :)];
        max_row = max_row + 1;
        current_name = name;
    end
end

% Convert last row to header
header_row = data(end, :);
data = data(1:end-1, :);

xlswrite('taxonomia_agrupada.xlsx', data, sheets{1});
writecell(header_row, 'taxonomia_agrupada.xlsx', 'Sheet', 1, 'Range', 'A1');


% Helper function to handle cell lengths
function value = getSecondToLast(x)
    if length(x) > 1
        value = x{end-1};
    else
        value = '';
    end
end