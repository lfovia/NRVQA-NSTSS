# Convert YUV Videos to Images
 
You can find an example on how to use the code in "example.m".

YUVREAD returns the Y, U and V components of a video in separate
matrices. Luma channel (Y) contains grayscale images for each frame. 
Chroma channels (U & V) have a lower sampling rate than the luma channel.

YUVREAD is able to read any common intermediate format with 4:2:0 
chroma subsampling. You just need to enter the correct width and height
information for the specific format:



(C)	Mohammad Haghighat, University of Miami
	haghighat@ieee.org
