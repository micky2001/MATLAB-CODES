clc
clear all
close all

%%Sampling frequency selection
fs=4e3;
dt=1/fs;
t=0:dt:.5;

%Test Signal
 Am=1;
 fm=50;
 x_t=Am*sin(2*pi*fm*t);

% TEST SIGNAL AFFECTED BY AWGN NOISE AT SNR  5 dB
xn_t=awgn(x_t,5,'measured');

%FILTERING OF NOISY SIGNAL
fc = 50;
[b,a] = butter(1,fc/(fs/2));
f_t = filter(b,a,xn_t);


%FIGURE PLOTTING IN TIME DOMAIN
figure
subplot(3,1,1)
plot(x_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Original Test Signal');
subplot(3,1,2)
plot(xn_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Noisy Test Signal');
subplot(3,1,3)
plot(f_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Filtered Test Signal');
suptitle('Time Domain Analysis')

%FIGURE PLOTTING IN FREQUNECY DOMAIN
figure
subplot(3,1,1)
periodogram(x_t,[],length(x_t),fs,'centered')
title('Original Test Signal');
subplot(3,1,2)
periodogram(xn_t,[],length(xn_t),fs,'centered')
title('Noisy Test Signal');
subplot(3,1,3)
periodogram(f_t,[],length(f_t),fs,'centered')
title('Filtered Test Signal');
suptitle('Frequency Domain Analysis')