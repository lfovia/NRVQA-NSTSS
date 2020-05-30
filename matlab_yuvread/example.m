%% Sample use of yuvRead

clc; clear; close all;


% Set the video information
videoSequence = 'sampleQCIF.yuv';
width  = 176;
height = 144;
nFrame = 500;


% Read the video sequence
[Y,U,V] = yuvRead(videoSequence, width, height ,nFrame); 


% Show sample frames
figure;
c = 0;  % counter
for iFrame = 25:25:500
    c = c + 1;
    subplot(4,5,c), imshow(Y(:,:,iFrame));
    title(['frame #', num2str(iFrame)]);
end
