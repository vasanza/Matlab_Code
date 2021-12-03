% Using white noise for data augmentation on temporal data
% Assuming that all the variables have the same amplitude
% input: data
% input: NoiseAmplitud -> Recommended(0.1 - 1)
% return: data
% Example to use:
% data = fLoad_Data_mat(datapath,'data_name');
% NoiseAmplitud = 0.5;%data folder
% data2=fDataAugmentation(data,NoiseAmplitud)

% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function [data2] = fDataAugmentation(data,NoiseAmplitud)
   r = rand(size(data,1),size(data,2))*NoiseAmplitud;
   data2=data+r;
end