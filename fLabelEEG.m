% Function that returns the label of each file with EEG data.
% input (fileNale): File Nale
% output (Label): Numeracy label

% Remember that for this experiment the labels represent:
% BEO, LCH, RCH, LDF, LPF, RDF, RPF, Descanso = "1", "2", "3", "4", "5", "6", "7", "8"

% Example: 
%   Label=fLabelEEG('S8R4M8_7_5.csv')

% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function [Label] = fLabelEEG(fileName)
    Label=[];
    ind=strfind(fileName,'R');
    if fileName(ind+2)=='I'
        Label=str2num(fileName(ind+3));
    else
        Label=str2num(fileName(ind+3))+8;
    end
end