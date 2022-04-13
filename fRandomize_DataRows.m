% Function that receives a set of data and arranges the rows randomly.
% input: Data
% return: Random Data
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [RandomData] = fRandomize_DataRows(Data)
    p = randperm(size(Data,1));
    RandomData=Data(p,:);    
end