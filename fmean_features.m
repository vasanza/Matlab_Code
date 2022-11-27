% Reshape Array using mean features by time windows
% input: Input Data (DataIn)
% input: Time window or timestep value (TimeStep)
% return: Reshape Array with mean features (DataMean)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [DataMean] = fmean_features(DataIn,TimeStep)
    DataMean=[];
        for i = 1:TimeStep:length(DataIn)-TimeStep
            DataMean=[DataMean; mean(DataIn(i:i+TimeStep,:))];
        end
        
end
