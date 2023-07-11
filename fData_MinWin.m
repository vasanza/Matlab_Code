% Function that returns the averaged data in a time window.
% input (allData): Data in time series
% input (Win): Time Window
% output (allDataMin): Data Min in time sales
% Example: 
%   win=60;% 1 minute
%   [allDataMin] = fData_MinWin(allData,Win)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [allDataMin] = fData_MinWin(allData,win)
    allDataMin=[];
    for i=1:win:length(allData)-win
        allDataMin=[allDataMin; min(allData(i:i+win,:))];
    end
end