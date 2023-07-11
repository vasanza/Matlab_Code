% Function that returns the std data in a time window.
% By: Abimael
% input (allData): Data in time series
% input (Win): Time Window
% output (allDataStd): Data Std in time sales
% Example: 
%   win=60;% 1 minute
%   [allDataMax] = fData_StdWin(allData,Win)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [allDataStd] = fData_StdWin(allData,win)
    allDataStd=[];
    for i=1:win:length(allData)-win
        allDataStd=[allDataStd; std(allData(i:i+win,:))];
    end
end