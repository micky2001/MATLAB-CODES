function[]=frequency_domain(ss,fs)
fs1=fs;
N1=length(ss);
vf1=fft(ss,N1);
vf2=vf1(1:round((N1+1)/2));
vf3=rot90(vf2,2);
vf=[vf3(1:length(vf3)-1) vf2];
va=(1/(fs1*N1))*abs(vf).^2;
f=-fs1/2+1:fs1/N1:fs1/2;
plot(f,10*log10(va));
xlabel('Frequency');
ylabel('PSD (dB/Hz)');

end