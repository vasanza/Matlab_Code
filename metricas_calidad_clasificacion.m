function [Exactitud,Precision,Sensibilidad,Especifidad,F1Score] = metricas_calidad_clasificacion(real,prediccion)
    C = confusionmat(real,prediccion)
    (C(1,1)+C(2,2))/(C(1,1)+C(1,2)+C(2,1)+C(2,2))*100;
    Exactitud=(C(1,1)+C(2,2))/(C(1,1)+C(1,2)+C(2,1)+C(2,2))*100
    Precision=(C(2,2)/(C(1,2)+C(2,2)))*100;
    Sensibilidad=(C(2,2)/(C(1,2)+C(2,2)))*100;
    Especifidad=(C(1,1)/(C(1,1)+C(1,2)))*100;%Recall
    F1Score=(2*Especifidad*Precision)/(Precision+Especifidad);
end