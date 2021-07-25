data(:,1)=[];data(:,2)=[];data(:,3)=[];
%%
data=load('data_v2.mat');data=data.data;
%data=table2array(data);
%%
figure;
plot(data.potencia(1000:5000));
hold on
plot(data.WORKSTATION_CPU(1000:5000));
hold on
plot(data.WORKSTATION_RAM(1000:5000));
legend('Potencia','% CPU','RAM');