clc
clear all
close all

N = 4096;
fs = 4e3;           % sampling frequency

%White Gaussian Noise of 10 dBW
wgn_no = wgn(N,1,10);              % 1- one dimension, N- no.of samples, 10-noise power

%Time domain representation
figure
subplot(2,2,1)
plot(wgn_no);
xlabel('Time');
ylabel('Amplitude (v)');
title('White Gaussian Noise in Time domain')

%PDF of Wgn Representation (PDF-power spectral density)
[f,x] = hist(wgn_no,100);
subplot(2,2,2)
bar(x,f/trapz(x,f));
xlabel('Values');
ylabel('PDF');
title('PDF of WGN')

% Frequency Domain representation
subplot(2,1,2)
frequency_domain(wgn_no,fs)

