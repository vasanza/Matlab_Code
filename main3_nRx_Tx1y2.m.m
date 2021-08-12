%%By:{vejaojed,vasanza,javiles}@espol.edu.ec
% Initialization
clc         
clear all   
close all
cd 'C:\Users\Laboratorio\Documents\MATLAB\Version2\'%Go to the root to execute the main code
addpath(genpath('./src'))%functions folders

% Select Rx to DELETE
idRx=[];%No elimina ningun Rx
%idRx=[1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39,41,43,45,47,49,51,53,55];%28 Rxs
%idRx=[1:29,31:56];%Esto es una prueba CON 1 rX


% Select only one Data Type
IdDataType = 3; %NO MODIFICAR - mW no random / solo ordenados

% Select only one Transmitter
IdTx = [1 11]; %NO MODIFICAR - Transmitter 1 and 2

% Select only one Label
Label = 1; %X
%Label = 2; %Y

% Select only one Quadrant
Qu = 1; %Quadrant 1
%Qu = 2; %Quadrant 2
%Qu = 3; %Quadrant 3
%Qu = 4; %Quadrant 4

% Importing raw data
fprintf('Initializing raw data\n')  
path = fullfile('./data/DATOSIMUL_STAR016_Tx01_Tx02_Ar09_56Rx_11Angs_CONSECTOR');%data folder

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
AllData=[];AllDataOut=[];
AllDataIn1=[];AllDataIn2=[];

for i=IdTx(1):IdTx(2)%go through folders
    path1=fullfile(path,folders(i).name);
    filenames=FindMAT(path1);
    len_filenames = length(filenames);
    data=load(fullfile(path1,filenames(IdDataType).name));%return a table file
    data=cell2mat(struct2cell(data));
    data(:,1)=[];%elimina la columna 1 muestra
    data(:,idRx)=[];%elimina la Rx <----------------------------
    if i>11
        data(:,size(data,2))=[];%elimina ultima columna <----------------------------
    end
    %DataIn=data(:,1:56);%elimina la columna 1
    %DataOut=data(:,56+Label);%Label
    %DataQu=data(:,59);%Quadrant
    AllDataIn1=[AllDataIn1;data(find(data(:,56-length(idRx)+3)==Qu),1:56-length(idRx))];
    AllDataOut=[AllDataOut;data(find(data(:,56-length(idRx)+3)==Qu),56-length(idRx)+Label)];
end

for i=IdTx(1)+11:IdTx(2)+11%go through folders
    path1=fullfile(path,folders(i).name);
    filenames=FindMAT(path1);
    len_filenames = length(filenames);
    data=load(fullfile(path1,filenames(IdDataType).name));%return a table file
    data=cell2mat(struct2cell(data));
    data(:,1)=[];%elimina la columna 1 muestra
    data(:,idRx)=[];%elimina la Rx <----------------------------
    if i>11
        data(:,size(data,2))=[];%elimina ultima columna <----------------------------
    end
    %DataIn=data(:,1:56);%elimina la columna 1
    %DataOut=data(:,56+Label);%Label
    %DataQu=data(:,59);%Quadrant
    AllDataIn2=[AllDataIn2;data(find(data(:,56-length(idRx)+3)==Qu),1:56-length(idRx))];
    %AllDataOut=[AllDataOut;data(find(data(:,56-length(idRx)+3)==Qu),56-length(idRx)+Label)];
end

AllData=[AllDataIn1 AllDataIn2 AllDataOut];
%csvwrite('AllData.mat',AllData)
save('AllData');
%% Call Linear Regression ToolBox
%load('AllData.mat');
%formatSpec = 'Esta prueba es con: IdDataType = %d, IdTx = %d, Label = %d and Quadrant %d';
%fprintf(formatSpec,IdDataType,IdTx,Label,Qu);