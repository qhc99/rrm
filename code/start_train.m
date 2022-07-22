clear;clc;close all;
N = 10;
train_size = 0.9*2e6;
data = load('table_data_2e6.mat');

[X,Y] = loadData(N, data.tasks_data,data.schedules_data);
XValidation = X(train_size+1:end,:,:,:);
YValidation =  Y(train_size+1:end,:);

XTrain = X(1:train_size,:,:,:);
YTrain =  Y(1:train_size,:);

fprintf(datestr(datetime) + ", load done\n");
save("dataset10.mat", 'XTrain',"YTrain",'XValidation','YValidation');

%layers = net();
%layers = convNet();
%net = continue_train(layers,train_size,XTrain,YTrain,XValidation,YValidation);