% Function to load a .mat file
% input: path -> Address where the files are stored
% input: file_name -> String file name to be uploaded
% return: File uploaded to worspace

% Example to use: Manuel File Upload
%   path = fullfile('./data/');%data folder
%   Data = fLoad_Data_mat(path,'AllDataFeatures.mat');

% Example to use: Automatic file upload
%addpath(genpath('./src'))
%path = fullfile('./data/');
%filenames=FindMAT(path);
%filenames=struct2table(filenames);
%filenames=filenames.name(:,1);
%DataAll=[];
%for i = 1:size(filenames,1)
%  dataNew=fLoad_Data_mat(path,filenames(i));
%  DataAll=[DataAll;dataNew];
%end

% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function [data] = fLoad_Data_mat(path,file_name)
    %Version 2
    data=importdata(char(strcat(path,file_name)));
    %Version 1
    %data=load(fullfile(path,strcat(file_name,'.mat')));
    %data=load(strcat(path,file_name),'-mat');
    %data=struct2cell(data);
    %data=data{1,1};% Return cell array
end
