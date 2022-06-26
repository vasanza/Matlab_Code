%Example for downloading data from Firebase and processing them
% by: Christopher Vaccaro (cvaccaro@espol.edu.ec)
% Last edition: 6/26/2022
% More examples: https://github.com/vasanza/Matlab_Code
% This code downloads the data from firebase, the data is sent from the open source hardware TSC-LAb, as described in the following link:
% https://tsc-lab.blogspot.com/2022/05/practice-41-firebase.html

%Read data from Realtime Firebase
data = webread("https://tsc-lab-default-rtdb.firebaseio.com/TSC-Lab.json");
values = data.Temperatura.Sensor1;
nLastSamples=1000;%ThingSpeak only allows viewing the last 8k samples.

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

% Set the time variable in the format 'HH:mm:ss'
Stamp = datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss');
% We separate the last n records (ThingSpeak only allows displaying the last 8k records).
t_LastStamp = Stamp(length(Stamp)-nLastSamples+1:length(Stamp));
x_LastSamples = x(length(x)-nLastSamples+1:length(x));
y_LastSamples = y(length(y)-nLastSamples+1:length(y));

%Plot of the first variable in subplot, with title, legends and names on the axes.
subplot(2,1,1)
plot(t_LastStamp,x_LastSamples,'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),x,'-*');
title('PWM on TSC-LAB');
xlabel('Time');ylabel('pwm (0 - 255)');
legend('pwm');
grid on

%Plot of the second variable in subplot, with title, legends and names on the axes.
subplot(2,1,2)
plot(t_LastStamp,y_LastSamples,'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),y,'-*');
title('Temperature on TSC-LAB');
xlabel('Time');ylabel('temperature (°C)');
legend('temperature');
grid on

%%
%Here is the code to display in ThingSpeak the last value received from Firebase
% TODO - Replace the [] with channel ID to read data from:
writeChannelID = [1244142];
% TODO - Replace the [] with the Field ID to read data from:
Field_Firebase = [8];
% Channel Write API Key 
% If your channel is private, then enter the read API
% Key between the '' below: 
writeAPIKey = 'S1EIDYYP6ZRR02FI';
%Last Time Stamp
LastStamp = t_LastStamp(length(t_LastStamp));
%Last Temperature Value
LastValue=y_LastSamples(length(y_LastSamples));

% Plot in field
%thingSpeakWrite(writeChannelID,'Field',Field_Firebase,'value', LastValue,'TimeStamp',LastStamp,'WriteKey',writeAPIKey)
thingSpeakWrite(writeChannelID,'Field',Field_Firebase,'value', LastValue,'WriteKey',writeAPIKey)
