% Function that returns ROC figure and tpr,fpr,thresholds
% input (Vectors nx1): TargetsClass,OuputClass  
% output (Figure): ROC figure
% output (Array): tpr - true positive rate, fpr - false positive rate,
% thresholds - Max correlation value

% Example: 
%      TargetsClass=[1;1;1;1;0;0;0;0];
%      OutputsClass=[1;1;1;1;0;0;0;1];
%   [tpr,fpr,thresholds]=ROC_AUC2(TargetsClass,OutputsClass)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [tpr,fpr,thresholds]=ROC_AUC2(TargetsClass,OutputsClass)
    Targets=[TargetsClass';not(TargetsClass)'];%El valor real (En una sola fila)
    Outputs=[OutputsClass';not(OutputsClass)'];%Prediccion del modelo (En una sola fila)
    [tpr,fpr,thresholds] = roc(Targets,Outputs);
    plotroc(Targets,Outputs);
end