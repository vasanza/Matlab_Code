% Function that returns the Median data in a time window.
% By: Cristian
% input (allData): Data in time series
% input (Win): Time Window
% output (allDataMedian): Data Median in time sales
% Example: 
%   win=60;% 1 minute
%   [allDataMax] = fData_MedianWin(allData,Win)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [allDataMedian] = fData_MedianWin(allData,win)
    allDataMedian=[];
    for i=1:win:length(allData)-win
        allDataMedian=[allDataMedian; median(allData(i:i+win,:))];
    end
end