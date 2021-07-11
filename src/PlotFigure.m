clear;clc;
Datos=load('agriculture.mat');Datos=Datos.agriculture;
Min=min(Datos);
Max=max(Datos);
%nomalization
nDatos=(Datos./Max);%-Min;
%% plot
figure
plot(nDatos(:,2:5));
hold on
plot(nDatos(:,6),'--');
legend("Relative Humidity","Environment Temperature","Soil moisture"...
    ,"Light intensity","Rain Occurrence",'NumColumns',3);