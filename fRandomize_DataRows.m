% Function that receives a set of data and arranges the rows randomly.
% input: Data
% return: Random Data (RandomData) and index of random rows (RowsIndex)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [RandomData,IndexRows] = fRandomize_DataRows(Data)
    IndexRows = randperm(size(Data,1));
    RandomData=Data(IndexRows,:);    
end