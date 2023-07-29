function [noisy_img] = noise(img)


% Define the noise types and their parameters
%noise_types = {'gaussian', 'salt & pepper', 'speckle', 'rician', 'periodic', 'poisson', 'rayleigh', 'gamma', 'quantization', 'brownian'};

% Define the error levels
noise_levels = [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9];
disp('1. Gaussian Noise');
disp('2. Salt & Pepper Noise');
disp('3. Speckle');
disp('4. Rician');
disp('5. Periodic');
disp('6. Poisson');
disp('7. Rayleigh');
disp('8. Gamma');
disp('9. Quantization');
disp('10. Brownian');

n=input('Enter the type of noise you want to enter in image: ');
l=input('Enter the level of noise you want to add in the image (1 for 0.1, 2 for 0.2 and so on...): ');

if(n==1)
    noisy_img = imnoise(img, 'gaussian',0, noise_levels(l));


elseif(n==2)
    noisy_img = imnoise(img, 'salt & pepper', noise_levels(l));


elseif(n==3)
    noisy_img = imnoise(img, 'speckle', noise_levels(l));


elseif(n==4)
    % Convert the image to double precision format
    img = im2double(img);
    
    % Set the signal-to-noise ratio (SNR)
    snr = 10;
    
    % Compute the standard deviation of the noise
    noise_std = mean(img(:)) / (10^(snr/20));
    
    % Generate two independent Gaussian noise components
    noise_real = noise_std * randn(size(img));
    noise_imag = noise_std * randn(size(img));
    
    % Add the noise to the image
    noisy_img = sqrt((img + noise_real).^2 + noise_imag.^2);

elseif(n==5)
   
    % Convert to double for processing
    img = im2double(img);
    
    % Define noise parameters
    amplitude = 0.1; % Noise amplitude
    frequency = noise_levels(l); % Noise frequency
    
    % Create periodic noise pattern
    [x, y] = meshgrid(1:size(img,2), 1:size(img,1));
    noise_pattern = amplitude * sin(2 * pi * frequency * x + 2 * pi * frequency * y);
    
    % Add periodic noise to the image
    noisy_img = img + noise_pattern;

elseif(n==6)
    % Convert to double for processing
    img = im2double(img);
    
    % Define noise parameters
    lambda = (noise_levels(10-l)*100); % Poisson parameter
    
    % Add Poisson noise to the image
    noisy_img = poissrnd(lambda * img) ./ lambda;

elseif(n==7)
    % Convert to double for processing
    img = im2double(img);
    
    % Define noise parameters
    scale = noise_levels(l); % Noise scale parameter
    
    % Add Rayleigh noise to the image
    noise_pattern = scale * randn(size(img)) + eps;
    noisy_img = img + noise_pattern .* img;

elseif(n==8)
    % Convert to double for processing
    img = im2double(img);
    
    % Define noise parameters
    shape = 1; % Gamma shape parameter
    scale = noise_levels(l); % Gamma scale parameter
    
    % Add Gamma noise to the image
    noise_pattern = scale * gamrnd(shape, 1/shape, size(img));
    noisy_img = img + noise_pattern;


elseif(n==9)
    % Calculate number of quantization levels
    n_levels = floor(256 / (100 / noise_levels(l)*10));
    
    % Generate the quantization noise
    q_noise = randn(size(img)) * n_levels / 256;
    noisy_img = im2double(img) + q_noise;
    noisy_img = im2uint8(noisy_img / max(noisy_img(:)));

elseif(n==10)

    % Define the standard deviation of the Brownian noise
    sigma = noise_levels(l);
    
    % Generate Brownian noise with the same size as the original image
    noise = sigma * cumsum(cumsum(randn(size(img))), 2);
    
    % Add the noise to the original image
    noisy_img = img + uint8(noise);

end
end


