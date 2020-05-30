%The following code creates a spatiotemporal 3d Gabor filter that prefers a given speed and direction of motion 

%created by: Nicolai Petkov and Easwar Subramanian
%Department of Mathematics and Computer Science
%University of Groningen
%The Netherlands

function result = GaborKernel3d(v,theta,xi,opt,bandwidth)

%Input : v     = preferred speed of the filter (in pixels per frame)
%	 theta = preferred direction of motion, The convention is that 0 is rightward motion with 
%		pi/2 and pi radians denoting upward and leftward motion.
%	 xi    = phase of the filter (symmteric or anti-symmteric)
%  	 opt   = If 0 the spatial Gaussian Envelope is stationary else the spatial Gaussian Envelope moves with the
%		 same speed as the harmonic (cosine) factor
%        bandwidth = bandwidth of the filter
	 

%output result : A three dimensional matrix that defines a normalized 3D Spatiotemporal Gabor filter

%usage : result = GaborKernel3d(1,0,0,1,1);

%setting of constants
%For the interpretation of the parameters, please refer to the relevant webpages 

%spatiotemporal period
lambda0 = 2;

%aspect ratio 
gamma = 0.5;


%mean of the temporal Gaussian
t0 = 1.75;

%standard deviation of the temporal Gaussian
tau = 2.75;

%calculate the spatial wavelength using the following relation
lambda = lambda0*sqrt(1+v^2);

%calculate the size 'sigma' of the receptive field 
slratio = (1/pi) * sqrt( (log(2)/2) ) * ( (2^bandwidth + 1) / (2^bandwidth - 1) );
sigma = slratio * lambda;

%determine the matrix size
n = ceil(7*sigma);

%do meshgrid to create the three dimensional matrix
[x,y,t] = meshgrid(-n:n,-n:n,-n:n);

%theta is set to pi - theta for conventional purposes (for ex, a value of 0 would mean rightward motion)
theta = pi - theta; 

%rotation matrix
xt = x * cos(theta) + y * sin(theta);
yt = -x * sin(theta) + y * cos(theta);
tt = t;

%Fix vf depending on whether the kernel has a stationary envelope or moving envelope
if(opt == 0)
    vf = 0;
else 
    vf = v;
end

%precompute few constants

%components of the cosine factor
xp = xt + v*t;
f1 = 2*pi/lambda;  
 
b = 1 / (2*sigma*sigma);  
tau2 = 1/(2*tau*tau);
gamma2 = gamma*gamma;

a = gamma / (2*sigma*sigma*pi);  %normalization for spatial gaussian
t1 = 1/(sqrt(2*pi)*tau);        %normalization for temporal gaussian 

%compute the kernel itself
result = (a*exp(-b*( (xt + vf*(tt)).*(xt + vf*(tt)) +gamma2* (yt.*yt)))).*(t1*(exp(-tau2*((tt - t0).*(tt-t0))))) .* cos(f1*xp +  xi); 

%For causality we do the following
result(:,:,1:n) = 0;

%The following part concerns normalization of the kernel. It is primarily done so that the filter does not respond for 
%constant input. The goal is make sure the integral of the kernel (sum of positive and negative values is zero)

% NORMALIZATION of positive and negative values to ensure that the integral of the kernel is 0.

ppos = find(result > 0); %pointer list to indices of elements of result which are positive
pneg = find(result < 0); %pointer list to indices of elements of result which are negative 

pos =     sum(result(ppos));  % sum of the positive elements of result
neg = abs(sum(result(pneg))); % abs value of sum of the negative elements of result
meansum = (pos+neg)/2;
if (meansum > 0) 
   pos = pos / meansum; % normalization coefficient for negative values of result
   neg = neg / meansum; % normalization coefficient for psoitive values of result
end

result(pneg) = pos*result(pneg);
result(ppos) = neg*result(ppos);

%The kernel can be viewed with the help of functions such as imagesc in matlab. One can
%view only one frame at a time. If the kernel is of size m*m*m, because of causality the first m/2 - 1 frames are set to zero. 
%Therefore, meaningful viewing is possible only from m/2 th frame. Further, one has to find the maximum value 
%and the minimum value of the kernel (say, maxker and minker, respectively) and add them as options in imagesc function in %order to see the change of intensity of the excitatory and inhibitory lobes of the kernel over different frames. 
%For example if the kernel is of size 16 * 16 * 16, one could use imagesc(result(:,:,9),[minker,maxker]); to view 9th %frame. 


