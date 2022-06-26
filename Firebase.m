%Example for downloading data from Firebase and processing them
% by: Christopher Vaccaro (cvaccaro@espol.edu.ec)
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://tsc-lab.blogspot.com/

%Read data from Realtime Firebase
data = webread("https://tsc-lab-default-rtdb.firebaseio.com/TSC-Lab.json");
values = data.Temperatura.Sensor1;
nLastSamples=100;%ThingSpeak only allows viewing the last 8k samples.

x=[];%We initialize the vector "x" as an empty array
y=[];%We initialize the vector "y" as an empty array
t=[];%We initialize the vector "t" as an empty array

%dates is a vector with all the days that the records were made.
dates = fieldnames(values);
for a = 1:length(dates)
    times = fieldnames(values.(dates{a}));
    %disp(times);
    %fprintf('date, time, data1, data2 \n');
    %Scrolls through all records made per day
    for b = 1:length(times)
        try %Depending on the connection, some data may not reach the firebase server.
            data1 = values.(dates{a}).(times{b}).pwm;
        end
        
        try %Depending on the connection, some data may not reach the firebase server.
            data2 = values.(dates{a}).(times{b}).temperature;
        end
        
        date = strrep(dates{a},"x","");
        date = strrep(date,"_","-");
        time = strrep(times{b},"x","");
        time = strrep(time,"_",":");
        t=[t strcat(date," ",time)];
        x=[x data1];
        y=[y data2];
        %fprintf('%s,%s,%d,%.2f\n', date, time, data1, data2);
    end
end

subplot(2,1,1)
plot(datetime(t(length(t)-nLastSamples:length(t)), 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),x(length(x)-nLastSamples:length(x)),'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),x,'-*');
title('PWM on TSC-LAB');
xlabel('Time');ylabel('pwm (0 - 255)');
legend('pwm');
grid on

subplot(2,1,2)
plot(datetime(t(length(t)-nLastSamples:length(t)), 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),y(length(y)-nLastSamples:length(y)),'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),y,'-*');
title('Temperature on TSC-LAB');
xlabel('Time');ylabel('temperature (°C)');
legend('temperature');
grid on
