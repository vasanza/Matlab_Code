% Function that returns the list of .TXT files
% input (path): address of the folder where the data is .TXT
% output (filenames): Complete list of .TXT file in folder
% Example: 
%   path = fullfile('./Data/');
%   filenames=FindMAT(path)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [filenames] = FindTXT(path)
    filenames = dir(fullfile(path ,'*.txt'));
    [~, reindex] = sort( str2double( regexp( {filenames.name}, '\d+', 'match', 'once' )));
    filenames = filenames(reindex);
end