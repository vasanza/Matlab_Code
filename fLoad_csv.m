% Function to load a .csv file
% input: path -> Address where the files are stored
% input: str_file_name -> String file name to be uploaded
% return: Data -> File uploaded to worspace
% Example to use: Manuel File Upload
%   path = fullfile('./data/');%data folder
%   Data = fLoad_csv(path,'AllDataFeatures.csv');

% Example to use: Automatic file upload
%addpath(genpath('./src'))
%path = fullfile('./data/');
%filenames=FindCSV(path);
%filenames=struct2table(filenames);
%filenames=filenames.name(:,1);
%DataAll=[];
%for i = 1:size(filenames,1)
%  dataNew=fLoad_csv(path,filenames(i));
%  DataAll=[DataAll;dataNew];
%end

% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function [Data] = fLoad_csv(path,str_file_name)
    %Version 2
    Data=importdata(char(strcat(path,str_file_name)));
    %Version 1
    %path1=fullfile(path,strcat(str_file_name,'.csv'));
    %data=readtable(path1);%Select CSV file
    %Data=table2array(data);% Array Double
end
