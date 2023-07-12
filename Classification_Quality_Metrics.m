% Function that returns Accuracy, Precision, Recall, and F1 Score.
% By: Monica
% input (real): Labels of real classification data
% input (prediction): Labels of predicted classification data
% output (Accuracy o Exactitud): Accuracy (%) = (TN + TP) / (TN + FP + FN + TP)
% output (Precision o Precision): Precision (%) = TP / (FP + TP)
% output (Recall o Especificida): Recall (%) = TP / (TP + FN)
% output (F1 Score): F1 Score (%) = (2 × Precision × Recall) / (Precision + Recall)
% Example:
%   [Accuracy, Precision, Recall,F1Score] = Classification_Quality_Metrics(real,prediction)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/

function [Accuracy, Precision, Recall,F1Score] = Classification_Quality_Metrics(real,prediction)
    C = confusionmat(real,prediction)
    Accuracy=(C(1,1)+C(2,2))/(C(1,1)+C(2,2)+C(2,1)+C(1,2))*100;
    Precision=(C(2,2)/(C(2,2)+C(1,2)))*100;
    Recall=(C(2,2)/(C(2,2)+C(2,1)))*100;
    F1Score=(2*Recall*Precision)/(Precision+Recall);
end