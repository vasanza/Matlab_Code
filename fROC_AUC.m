% Function that returns ROC figure and tpr,fpr,thresholds
% input (Vectors nx1): TargetsClass,OuputClass 
% input (char): idClass1,idClass2
% output (Figure): ROC figure
% output (Array): tpr - true positive rate, fpr - false positive rate,
% thresholds - Max correlation value

% Example: 
%      TargetsClass=[1;1;1;1;0;0;0;0];
%      OutputsClass=[1;1;1;1;0;0;0;1];
%      idClass1='1';
%      idClass2='0';
%   function [tpr,fpr,thresholds]=fROC_AUC(TargetsClass,OutputsClass,idClass1,idClass2)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [tpr,fpr,thresholds]=fROC_AUC(TargetsClass,OutputsClass,idClass1,idClass2)
    [tpr,fpr,thresholds] = roc(TargetsClass',OutputsClass');
    
    figure
    rocObj1 = rocmetrics(TargetsClass,OutputsClass,idClass1);
    rocObj0 = rocmetrics(TargetsClass,OutputsClass,idClass2);
    plot(rocObj1)
    hold on
    plot(rocObj0)
    hold on
end
