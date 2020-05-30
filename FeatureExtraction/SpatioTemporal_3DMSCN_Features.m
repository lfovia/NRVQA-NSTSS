%%%% This script extracts the 3D MSCN features of the natural videos %%%%%%%%%
clc;clear all;close all;
addpath('./matlab_yuvread')
addpath('./videos');
addpath('./src');
f=importdata('video_file_names.txt');
files = f.textdata;
video_info = f.data;

N = length(files);
features_set = zeros(N,4);
for v_id = 1:1:N
    v_id
    features = [];
    [Y,U,V] = yuvRead(files{v_id}, video_info(v_id,2), video_info(v_id,3) ,video_info(v_id,4));
    Y=double(Y);
    Y= divisiveNormalization3D(Y);
    [alpha leftstd rightstd] = estimateaggdparam(Y(:));
    features = [alpha leftstd rightstd (alpha/((leftstd+rightstd)/2))];
    features_set(v_id,:) = features;
    save('3dmscn_features.mat','features_set','-v7.3');
end

