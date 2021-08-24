<<<<<<< HEAD
% Reshape Array using rms features by time windows
% input: Input Data (DataIn)
% input: Time window or timestep value (TimeStep)
% return: Reshape Array with rms features (DataRMS)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [DataRMS] = frms_features(DataIn,TimeStep)
    DataRMS=[];
    for i = 1:size(DataIn,2)%columnas
        Feature=[];
        for j = 1:TimeStep:size(DataIn,1)-TimeStep%filas
            Feature=[Feature; rms(DataIn(j:j+TimeStep,i))];
        end
        DataRMS=[DataRMS Feature];
    end
=======
% Reshape Array using rms features by time windows
% input: Input Data (DataIn)
% input: Time window or timestep value (TimeStep)
% return: Reshape Array with rms features (DataRMS)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [DataRMS] = frms_features(DataIn,TimeStep)
    DataRMS=[];
    for i = 1:size(DataIn,2)%columnas
        Feature=[];
        for j = 1:TimeStep:size(DataIn,1)-TimeStep%filas
            Feature=[Feature; rms(DataIn(j:j+TimeStep,i))];
        end
        DataRMS=[DataRMS Feature];
    end
>>>>>>> 81621d7ab1e99236a004fd14fbcbc9e18898f652
end