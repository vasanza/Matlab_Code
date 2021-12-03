% Function to Save a .mat file
% input: path -> Address where the files will be saved
% input: 'file_name' -> String file name to be saved
% return: null
% Example to use:
%datapath=fullfile('./data/');%data folder
% fLoad_Data_mat(datapath,'filename')

% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function fSave_Data_mat(path,file_name)
    
    save(strcat(path,strcat(file_name,'.mat')),'file_name');
end