function [filtered_img] = chebyshev_lp(input_img, filter_len, cutoff_freq, passband_ripple)
% Inputs:
%   input_img: the input image to be filtered
%   fir_coeff: the existing FIR filter coefficients (row vector)
%   filter_len: the length of the Chebyshev Type I filter
%   cutoff_freq: the cutoff frequency of the Chebyshev Type I filter
%   passband_ripple: the passband ripple of the Chebyshev Type I filter (in dB)
% Outputs:
%   filtered_img: the filtered image


% Design the Chebyshev Type I filter using cheby1() function
rp = passband_ripple; % passband ripple in dB
rs = 40; % stopband attenuation in dB
[b, a] = cheby1(filter_len-1, rp, cutoff_freq);

% Convert the filter to FIR using the impulse invariance method
filter_coeff = impz(b, a);

% Apply the filter to the input image
for i=1:size(input_img,3)
    filtered_img(:,:,i) = filter(filter_coeff,1,double(input_img(:,:,i)));
end

% Convert the filtered image back to uint8 format
filtered_img = uint8(filtered_img);
end
