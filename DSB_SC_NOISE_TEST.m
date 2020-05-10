clc
clear all
close all

%%Sampling frequency selection
fs=4e3;
dt=1/fs;
t=0:dt:.5;

%Meassage Signal
Am=1;
fm=50;
m_t=Am*cos(2*pi*fm*t);

%Carrier Signal
Ac=1;
fc=300;
c_t=Ac*cos(2*pi*fc*t);

%DSB-C MODULATED SIGNAL
m=0.75; 
s_t=m_t.*c_t;


%DEMODULATION OF DSB-C SIGNAL (Coherrent detection)
xx_t=s_t.*c_t;
fc = 40; 
[b,a] = butter(1,fc/(fs/2));
m1_t = filter(b,a,xx_t);

%DEMODULATION OF DSB-C SIGNAL (Envelope detection)
s1_t=s_t;
for(i=1:length(s1_t))
    if(s1_t(i)<0)
        s1_t(i)=0;
    end
end
fc = 50; 
[b,a] = butter(2,fc/(fs/2));
m11_t = filter(b,a,s1_t);


% MODULATED SIGNAL AFFECTED BY AWGN NOISE AT SNR  5 dB
sn_t=awgn(s_t,5,'measured');

%DEMODULATION OF NOISY DSB-C SIGNAL (Coherent detection)
xx1_t=sn_t.*c_t;
fc = 50; 
[b,a] = butter(1,fc/(fs/2));
m1_n_t = filter(b,a,xx1_t);


%DEMODULATION OF NOISY DSB-C SIGNAL (Envelope detection)
sn1_t=sn_t;
for(i=1:length(sn1_t))
    if(sn1_t(i)<0)
        sn1_t(i)=0;
    end
end
fc = 50; 
[b,a] = butter(2,fc/(fs/2));
m11_n_t = filter(b,a,sn1_t);


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
title('DSB-C AM Signal')
subplot(2,2,4)
plot(sn_t);
xlabel('Time');
ylabel('Amplitude (V)');
title(' Noisy DSB-C AM Signal')
suptitle('Message, Modulated signal, Noisy modulated signal (Time Domain)')

%FIGURE PLOTTING IN FREQUNECY DOMAIN for using periodogram
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
% title('DSB-C AM Signal')
% subplot(2,2,4)
% periodogram(sn_t,[],length(sn_t),fs,'centered')
% title(' Noisy DSB-C AM Signal')
% suptitle('Message, Modulated signal, Noisy modulated signal (Frequency Domain)')
% 

%FIGURE PLOTTING IN FREQUNECY DOMAIN for using fft
figure
subplot(2,2,1)
plot(m_t);
frequency_domain(m_t,fs)
title('Message Signal')
subplot(2,2,2)
frequency_domain(m_t,fs)
title('Message Signal')
subplot(2,2,3)
frequency_domain(s_t,fs)
title('DSB-C AM Signal')
subplot(2,2,4)
frequency_domain(sn_t,fs)
title(' Noisy DSB-C AM Signal')
suptitle('Message, Modulated signal, Noisy modulated signal (Frequency Domain)')


%FIGURE PLOTTING IN TIME DOMAIN
figure
subplot(3,2,1)
plot(s_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('DSB-C AM Signal')
subplot(3,2,2)
plot(sn_t);
xlabel('Time');
ylabel('Amplitude (V)');
title(' Noisy DSB-C AM Signal')
subplot(3,2,3)
plot(m11_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Demodulated Signal (Envelop det.)')
subplot(3,2,4)
plot(m11_n_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Noisy Demodulated Signal (Envelop det.)')
subplot(3,2,5)
plot(m1_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Demodulated Signal (Coherent det.)')
subplot(3,2,6)
plot(m1_n_t);
xlabel('Time');
ylabel('Amplitude (V)');
title('Noisy Demodulated Signal (Coherent det.)')
suptitle('Modulated signal, Demodulated signals (Time Domain)')




%FIGURE PLOTTING IN FREQUNECY DOMAIN
figure
subplot(3,2,1)
frequency_domain(s_t,fs)
title('DSB-C AM Signal')
subplot(3,2,2)
frequency_domain(sn_t,fs)
title(' Noisy DSB-C AM Signal')
subplot(3,2,3)
frequency_domain(m11_t,fs)
title('Demodulated Signal (Envelop det.)')
subplot(3,2,4)
frequency_domain(m11_n_t,fs)
title('Noisy Demodulated Signal (Envelop det.)')
subplot(3,2,5)
frequency_domain(m1_t,fs)
title('Demodulated Signal (Coherent det.)')
subplot(3,2,6)
frequency_domain(m1_n_t,fs)
title('Noisy Demodulated Signal (Coherent det.)')
suptitle('Modulated signal, Demodulated signals (Frequency Domain)')
