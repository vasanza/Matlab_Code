% Example for downloading data from Firebase and Predicting values by Linear Regression them, this code can be run in Matlab or in ThingSpeak.
% The data is sent from the open source hardware TSC-LAb, as described in the following link:
% https://tsc-lab.blogspot.com/2022/05/practice-41-firebase.html
% Last edition: 7/03/2022
% More examples: https://github.com/vasanza/Matlab_Code
% Read more: https://vasanza.blogspot.com/


%%Read data from Realtime Firebase
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
%subplot(2,1,1)
%plot(t_LastStamp,x_LastSamples,'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),x,'-*');
%title('PWM on TSC-LAB');
%xlabel('Time');ylabel('pwm (0 - 255)');
%legend('pwm');
%grid on

%Plot of the second variable in subplot, with title, legends and names on the axes.
%subplot(2,1,2)
%plot(t_LastStamp,y_LastSamples,'-*');
%plot(datetime(t, 'inputformat','yyyy-MM-dd HH:mm:ss', 'Format','HH:mm:ss'),y,'-*');
%title('Temperature on TSC-LAB');
%xlabel('Time');ylabel('temperature (°C)');
%legend('temperature');
%grid on

%%------------ Preparing data for linear regression model training and prediction validation
y=y';
DataInOut=[y(1:length(y)-1) y(2:length(y),:)];
TrainingPercentage=0.8; %Training percentage
%Training and validation data division
DataTrain=DataInOut(1:length(DataInOut)*TrainingPercentage,:);
DataValidation=DataInOut(length(DataInOut)*TrainingPercentage:length(DataInOut),:);

%%------------ Linear Regression Function
trainingData=DataTrain;
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2'});

predictorNames = {'column_1'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_2;
isCategoricalPredictor = [false];

% Train a regression model
% This code specifies all the model options and trains the model.
concatenatedPredictorsAndResponse = predictors;
concatenatedPredictorsAndResponse.column_2 = response;
linearModel = fitlm(...
    concatenatedPredictorsAndResponse, ...
    'linear', ...
    'RobustOpts', 'off');

% Create the result struct with predict function
predictorExtractionFcn = @(x) array2table(x, 'VariableNames', predictorNames);
linearModelPredictFcn = @(x) predict(linearModel, x);
trainedModel.predictFcn = @(x) linearModelPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedModel.LinearModel = linearModel;
trainedModel.About = 'This struct is a trained model exported from Regression Learner R2022a.';
trainedModel.HowToPredict = sprintf('To make predictions on a new predictor column matrix, X, use: \n  yfit = c.predictFcn(X) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nX must contain exactly 1 columns because this model was trained using 1 predictors. \nX must contain only predictor columns in exactly the same order and format as your training \ndata. Do not include the response column or any columns you did not import into the app. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appregression_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
% Convert input to table
inputTable = array2table(trainingData, 'VariableNames', {'column_1', 'column_2'});

predictorNames = {'column_1'};
predictors = inputTable(:, predictorNames);
response = inputTable.column_2;
isCategoricalPredictor = [false];

% Perform cross-validation
KFolds = 10;
cvp = cvpartition(size(response, 1), 'KFold', KFolds);
% Initialize the predictions to the proper sizes
validationPredictions = response;
for fold = 1:KFolds
    trainingPredictors = predictors(cvp.training(fold), :);
    trainingResponse = response(cvp.training(fold), :);
    foldIsCategoricalPredictor = isCategoricalPredictor;

    % Train a regression model
    % This code specifies all the model options and trains the model.
    concatenatedPredictorsAndResponse = trainingPredictors;
    concatenatedPredictorsAndResponse.column_2 = trainingResponse;
    linearModel = fitlm(...
        concatenatedPredictorsAndResponse, ...
        'linear', ...
        'RobustOpts', 'off');

    % Create the result struct with predict function
    linearModelPredictFcn = @(x) predict(linearModel, x);
    validationPredictFcn = @(x) linearModelPredictFcn(x);

    % Add additional fields to the result struct

    % Compute validation predictions
    validationPredictors = predictors(cvp.test(fold), :);
    foldPredictions = validationPredictFcn(validationPredictors);

    % Store predictions in the original order
    validationPredictions(cvp.test(fold), :) = foldPredictions;
end

% Compute validation RMSE
isNotMissing = ~isnan(validationPredictions) & ~isnan(response);
validationRMSE = sqrt(nansum(( validationPredictions - response ).^2) / numel(response(isNotMissing) ));

%%------------  Prediction graph with validation data
yest=trainedModel.predictFcn(DataValidation(:,1));
yreal=DataValidation(:,2);

plot(yest)
hold on
plot(yreal)
title('Prediction graph with validation data');
xlabel('Time');ylabel('temperature (°C)');
legend('yest','yreal')