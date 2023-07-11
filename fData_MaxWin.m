% Function that returns the averaged data in a time window.
% input (allData): Data in time series
% input (Win): Time Window
% output (allDataMax): Data Max in time sales
% Example: 
%   win=60;% 1 minute
%   [allDataMax] = fData_MaxWin(allData,Win)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [allDataMax] = fData_MaxWin(allData,win)
    allDataMax=[];
    for i=1:win:length(allData)-win
        allDataMax=[allDataMax; max(allData(i:i+win,:))];
    end
end