clc;clear all; close all;
addpath("./logisticfitting");
addpath("./FeatureExtraction");

scores = importdata('subjective_scores.txt');
DMOS = scores;
load('3dmscn_features.mat');
features  = features_set;
no_of_iterations = 100;
TrainRatio = 0.8;
TestRatio = 0.2;
ValidationRatio = 0;
temp=[];
for iter = 1:1:no_of_iterations
[trainInd,valInd,testInd] = dividerand(size(features_set,1),TrainRatio,ValidationRatio,TestRatio);
mdl = fitrsvm(features(trainInd,:),DMOS(trainInd),'KernelFunction','rbf','KernelScale','auto','Standardize',true,'CacheSize','maximal');
y_cap = predict(mdl,features(testInd,:));
mos_cap = DMOS(testInd);
temp(iter,:) = calculatepearsoncorr(y_cap,mos_cap);
median(temp)
end
