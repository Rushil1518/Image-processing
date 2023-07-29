function [MSE,RMSE,PSNR,SSIM,IEF] = params(originalImg,filteredImg,noisyImg)
noisyImg = double(noisyImg);
filteredImg = double(filteredImg);
% MSE RMSE PSNR SSIM IEF

% MSE
MSE = mean(mse(filteredImg,noisyImg));

% RMSE
RMSE = sqrt(MSE);

% PSNR
peakVal = max(max(max(filteredImg)));
PSNR = 10*log10(double(peakVal^2)/MSE);

% SSIM
SSIM = ssim(filteredImg,noisyImg);

% IEF
IEF = ief(originalImg,noisyImg,filteredImg);


end