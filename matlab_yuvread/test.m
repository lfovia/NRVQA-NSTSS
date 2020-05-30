%% Sample use of yuvRead

clc; clear; close all;
addpath '/home/sathya/Downloads/YUV_RBG/YUV'
addpath '/home/sathya/Downloads/LIVE_SD'
files = importdata('live_sd_names.txt');
for vid = 1:1:160
    videoSequence = files{vid};
    width  = 768;
    height = 432;
    nFrame = 217;
    % Read the video sequence
    [Y,U,V] = yuvRead(videoSequence, width, height ,nFrame);
    for i = 1:1:size(Y,3)
        rgb_video(i,:,:,:) = yuv2rgb(Y(:,:,i),U(:,:,i),V(:,:,i));
    end
    vid
    save(strcat(videoSequence,'.mat'),'rgb_video','-v7.3');
end
% Set the video information
