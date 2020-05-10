clc
clear all
close all

%%Sampling frequency selection
fs=6e3;
dt=1/fs;
t=0:dt:.5;

%Message Signal
Am=1;
fm=40;
m_t=Am*cos(2*pi*fm*t);
mh_t=Am*sin(2*pi*fm*t);

%Carrier Signal
Ac=1;
fc=400;
c_t=Ac*cos(2*pi*fc*t);
c1_t=Ac*sin(2*pi*fc*t);

%SSB-SC (LSB) MODULATED SIGNAL
s_t=0.5*(m_t.*c_t+mh_t.*c1_t);


%DEMODULATION OF SSB-SC SIGNAL (Coherrent detection)
xx_t=s_t.*c_t;
fc = 40; 
[b,a] = butter(1,fc/(fs/2));
m1_t = filter(b,a,xx_t);



% MODULATED SIGNAL AFFECTED BY AWGN NOISE AT SNR  5 dB
sn_t=awgn(s_t,5,'measured');

%DEMODULATION OF NOISY SSB-SC SIGNAL (Coherent detection)
xx1_t=sn_t.*c_t;
fc = 40; 
[b,a] = butter(1,fc/(fs/2));
m1_n_t = filter(b,a,xx1_t);



%FIGURE PLOTTING IN TIME DOMAIN
figure
subplot(2,2,1)
plot(m_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Message Signal')
subplot(2,2,2)
plot(m_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Message Signal')
subplot(2,2,3)
plot(s_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('SSB-SC AM Signal')
subplot(2,2,4)
plot(sn_t);
xlabel('Time');
ylabel('Amplitude (V)');
title(' Noisy SSB-SC AM Signal')
suptitle('Message, Modulated signal, Noisy modulated signal (Time Domain)')



% FIGURE PLOTTING IN FREQUNECY DOMAIN
% figure
% subplot(2,2,1)
% plot(m_t);
% periodogram(m_t,[],length(m_t),fs,'centered')
% title('Message Signal')
% subplot(2,2,2)
% periodogram(m_t,[],length(m_t),fs,'centered')
% title('Message Signal')
% subplot(2,2,3)
% periodogram(s_t,[],length(s_t),fs,'centered')
% title('SSB-SC AM Signal')
% subplot(2,2,4)
% periodogram(sn_t,[],length(sn_t),fs,'centered')
% title(' Noisy SSB-SC AM Signal')
% suptitle('Message, Modulated signal, Noisy modulated signal (Frequency Domain)')

%FIGURE PLOTTING IN FREQUNECY DOMAIN
figure
subplot(2,2,1)
plot(m_t);
frequency_domain(m_t,fs);
subplot(2,2,2)
frequency_domain(m_t,fs);
title('Message Signal')
subplot(2,2,3)
frequency_domain(s_t,fs);
title('SSB-SC AM Signal')
subplot(2,2,4)
frequency_domain(sn_t,fs);
title(' Noisy SSB-SC AM Signal')
suptitle('Message, Modulated signal, Noisy modulated signal (Frequency Domain)')








%FIGURE PLOTTING IN TIME DOMAIN
figure
subplot(2,2,1)
plot(s_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('SSB-SC AM Signal')
subplot(2,2,2)
plot(sn_t);
xlabel('Time');
ylabel('Amplitude (V)');
title(' Noisy SSB-SC AM Signal')
subplot(2,2,3)
plot(m1_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Demodulated Signal (Coherent det.)')
subplot(2,2,4)
plot(m1_n_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Noisy Demodulated Signal (Coherent det.)')
suptitle('Modulated signals, Demodulated signals (Time Domain)')




%FIGURE PLOTTING IN FREQUNECY DOMAIN
figure
subplot(2,2,1)
frequency_domain(s_t,fs)
title('SSB-SC AM Signal')
subplot(2,2,2)
frequency_domain(sn_t,fs)
title(' Noisy SSB-SC AM Signal')
subplot(2,2,3)
frequency_domain(m1_t,fs)
title('Demodulated Signal (Coherent det.)')
subplot(2,2,4)
frequency_domain(m1_n_t,fs)
title('Noisy Demodulated Signal (Coherent det.)')
suptitle('Modulated signals, Demodulated signals (Frequency Domain)')
