%Example for displaying data in ThingSpeak
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://tsc-lab.blogspot.com/

% TODO - Replace the [] with channel ID to read data from:
readChannelID = [1244142];

% TODO - Replace the [] with the Field ID to read data from:
Temperature1 = [1];
Temperature2 = [2];

% Channel Read API Key 
% If your channel is private, then enter the read API
% Key between the '' below: 
readAPIKey = 'MBKC6SNZ6PD8XZAT';

% Read Data %%

[data1, time1] = thingSpeakRead(readChannelID, 'Field', Temperature1, 'NumPoints', 8000, 'ReadKey', readAPIKey);
[data2, time2] = thingSpeakRead(readChannelID, 'Field', Temperature2, 'NumPoints', 8000, 'ReadKey', readAPIKey);

% Visualize Data %%

plot(time1, data1);
hold on
plot(time2, data2);
title('TSC-LAB Temperature');
xlabel('Time');ylabel('°C');
legend('Temp1','Temp2');