% This script is intended to download the abundances of bacteria from the
% article Dan Z, Mao X, Liu Q, Guo M et al.
% Altered gut microbial profile is associated with abnormal metabolism
% activity of Autism Spectrum Disorder.
% Gut Microbes 2020 Sep 2;11(5):1246-1267
% 
% Before downloading, change the path of destination, then run the script in MATLAB 2014 or newer.
%

url = 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE113690&format=file&file=GSE113690%5FAutism%5F16S%5FrRNA%5FOTU%5Fassignment%5Fand%5Fabundance%2Exls%2Egz';

% Replace "path_to_save_file" with the full path of the desired destination
% folder
destinationFilePath = 'path_to_save_file\GSE113690_Autism_16S_rRNA_OTU_assignment_and_abundance.xls.gz';

% websave function is used to download the file
try
    websave(destinationFilePath, url);
    disp('File downloaded successfully.');
catch
    disp('Error downloading the file. Check the URL or your internet connection.');
end
