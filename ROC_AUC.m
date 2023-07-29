% Function that returns ROC figure and tpr,fpr,thresholds
% input (Vectors nx1): TargetsClass1,TargetsClass2,OuputClass1,OutputClass2,  
% output (Figure): ROC figure
% output (Array): tpr - true positive rate, fpr - false positive rate,
% thresholds - Max correlation value

% Example: 
%      TargetsCLase1=[1;1;1;1];
%      TargetsCLase2=[0;0;0;0];
%      OutputsCLase1=[1;1;1;1];
%      OutputsCLase2=[0;0;0;1];
%   [tpr,fpr,thresholds]=ROC_AUC(TargetsCLase1,TargetsCLase2,OutputsCLase1,OutputsCLase2)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/
function [tpr,fpr,thresholds]=ROC_AUC(TargetsCLase1,TargetsCLase2,OutputsCLase1,OutputsCLase2)
    Targets=[TargetsCLase1';not(TargetsCLase2)'];%El valor real (En una sola fila)
    Outputs=[OutputsCLase1';not(OutputsCLase2)'];%Prediccion del modelo (En una sola fila)
    [tpr,fpr,thresholds] = roc(Targets,Outputs);
    plotroc(Targets,Outputs);
end