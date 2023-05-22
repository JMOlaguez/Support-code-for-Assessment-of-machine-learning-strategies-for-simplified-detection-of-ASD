% File name and sheet number
filename = 'DAN_MATLAB.xlsx';
sheet = 2;

% Import the data from the excel file
[numData, textData, raw] = xlsread(filename, sheet);

% Extract the variable names from the first raw
headers = raw(1, :);

% Extract the numerical data from raw 1 until the end
numData = numData(1:end, :);

% Create variables for each column
for col = 1:size(numData, 2)
    columnName = headers{col};
    eval([columnName ' = numData(:, col);']);
end

% Display the imported data
disp('Imported Data:');
disp(headers);


headers2=headers(3:25);

% Iterate through headers2
for i = 1:numel(headers2)
    % Extract the element for t-test
    element = eval(headers2{i});
    
    % Perform t-test
    [h, p] = ttest2(element(1:143), element(144:254), 0.05, 'both');
    
    % Display results
    fprintf('Bacteria genus: %s\n', headers2{i});
    fprintf('h = %d, p = %f\n\n', h, p);
end