%%%% This script extracts the quadrature spatiotemporal features using Gabor decomposition of the natural videos %%%%%%%%%
clc;clear all;close all;
addpath('./matlab_yuvread')
addpath('./videos');
addpath('./src');
f=importdata('video_file_names.txt');
files = f.textdata;
video_info = f.data;

N = length(files);

xi = pi/2; opt = 1; bandwidth = 1;
features_set_sin = zeros(N,48);
for v_id = 1:1:N
    v_id
    features = [];
    [Y,U,V] = yuvRead(files{v_id}, video_info(v_id,2), video_info(v_id,3) ,video_info(v_id,4));
    Y=double(Y);
    Y= divisiveNormalization3D(Y);
    G = gpuArray(Y);
    clear Y;
    for v = 0:1:2
        for theta = 0:60:180
            result = GaborKernel3d(v,theta,xi,opt,bandwidth);
            result = result./max(result(:));
            H = gpuArray(result);
            clear result;
            C = convn(G,H,'same');
            C_cap= gather(C);
            [alpha leftstd rightstd] = estimateaggdparam(C_cap(:));
            clear C_cap C H;
            features = [features alpha leftstd rightstd (alpha/((leftstd+rightstd)/2))];
        end
    end
    features_set_sin(v_id,:) = features;
    clear G;
    save('spatiotemporal_quadrature_features.mat','features_set_sin','-v7.3');
end

