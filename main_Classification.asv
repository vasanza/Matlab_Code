%%By:{vejaojed,vasanza,javiles}@espol.edu.ec
% Initialization
clc         
clear all   
close all
%cd 'C:\Users\Laboratorio\Documents\MATLAB\Version2\'%Go to the root to execute the main code
addpath(genpath('./src'))%functions folders

% Select only one Data Type
%IdDataType = 1; %dB no random
%IdDataType = 2; %dB random
IdDataType = 3; %mW no random
%IdDataType = 4; %mW random

% Select only one Transmitter
IdTx = [1 11]; %Transmitter 1
%IdTx = [12 22]; %Transmitter 1
%IdTx = [1 22]; %Transmitter 1 & 2

% Now Label is Quadrant
Label = 3;

% Importing raw data
fprintf('Initializing raw data\n')  
path = fullfile('./data/2021_Junio_T1_T2/');%data folder

files = dir(path);
dirFlags = [files.isdir];
folders = files(dirFlags);
folders = folders(~ismember({folders.name},{'.','..','logfiles'}));
%% Test comment this
% path1=fullfile(path,folders(1).name);
% filenames=FindMAT(path1);
% data=load(fullfile(path1,filenames(IdDataType).name));%return a table file
% data=cell2mat(struct2cell(data));
% data(:,1)=[];%elimina la columna 1 muestra
% DataIn=data(:,1:56);%elimina la columna 1
% DataOut=data(:,56+Label);%Label
% DataQu=data(:,59);%Quadrant
%%
AllData=[];AllDataIn=[];AllDataOut=[];
for i=IdTx(1):IdTx(2)%go through folders
    path1=fullfile(path,folders(1).name);
    filenames=FindMAT(path1);
    len_filenames = length(filenames);
    data=load(fullfile(path1,filenames(IdDataType).name));%return a table file
    data=cell2mat(struct2cell(data));
    data(:,1)=[];%elimina la columna 1 muestra
    %DataIn=data(:,1:56);%elimina la columna 1
    %DataOut=data(:,56+Label);%Label
    %DataQu=data(:,59);%Quadrant
    AllDataIn=[AllDataIn;data(:,1:56)];
    AllDataOut=[AllDataOut;data(:,56+Label)];
end
AllData=[AllDataIn AllDataOut];
%csvwrite('AllData.mat',AllData)
save('AllData');
%% Call Linear Regression ToolBox
load('AllData.mat');
formatSpec = 'Esta prueba es con: IdDataType = %d, IdTx = %d, Label = %d and Quadrant %d';
fprintf(formatSpec,IdDataType,IdTx,Label,Qu);