function [structdis,vMinusMu,mu,sigma]= divisiveNormalization3D(video_dist)
    mu = imgaussfilt3(video_dist,7/6,'filtersize',[5 5 5]);
    mu_sq = mu.*mu;
    sigma = sqrt(abs(imgaussfilt3(video_dist.*video_dist,7/6,'filtersize',[5 5 5])-mu_sq));
    vMinusMu = (video_dist-mu);
    structdis =vMinusMu./(sigma +1);
end