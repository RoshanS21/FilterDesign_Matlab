% Roshan Shrestha
% Filter Design

clc
clear
close all
% 1
% read audio sample
% a
[x1, Fs] = audioread('noisyaudio.wav');
% DFT of audio sample
% b
x2 = fft(x1);
n = length(x1);
% c
% form a frequency axis from -Fs/2 to +Fs/2
axis = linspace(-Fs/2, Fs/2, n);
% d
% plot DFT vs frequency with w = 0 at center of plot
x3 = fftshift(x2);
x4 = abs(x3);
subplot(221);
plot(axis, x4), ylabel('Magnitude of DFT'), xlabel('frequency'), title('DFT vs. frequency')
grid on;
% e
% Normalized log plot of DFT
% xdB = 20log10(x)
x5 = 20*log10(abs(fftshift(x2/n)));
subplot(223);
plot(axis, x5), ylabel('Normalized Log of DFT'), xlabel('frequency'), title('Normalized log plot of DFT')
grid on;

% 2
% f
% decide on wp and ws
% wp -> end of the pass band
% ws -> beginning of stop band
% Hz
wP = 2300;
wS = 2500;
% g
% attenuation
% 1 - delP is delP, delS, dB
% value in dB, so calculate actual value
delP = 10^(-3/20);
delS = 10^(-50/20);
% h
% filter order:N, cutoff frequency: omegaC
kp = 1/((1-delP)^2)-1;
ks = 1/(delS^2)-1;
N = 1/2*log(ks/kp)/log(wS/wP);
N = ceil(N);
oC = wP/(kp^(1/(2*N)));
% i
wC = oC/Fs;
% j
%{
Hs = zeros(1,n);
for i = 1:n
    temp = -10*log10(1+(axis(i)/wC)^(2*N));
    Hs(i) = temp;
end
i = linspace(1,n,1);
subplot(3,1,3);
plot(i,abs(Hs))
%}

% 3
% a
[b,a] = butter(N,oC/(Fs/2));
% b
Y = filter(b,a,x1);
% c
dftY = fft(Y);
subplot(222);
plot(axis, abs(dftY)), ylabel('Magnitude'), xlabel('frequency'), title('DFT Filtered Audio')
grid on;
% d
subplot(224);
plot(axis, x4), ylabel('Magnitude'), xlabel('frequency'), title('Comparison')
hold on
plot(axis, abs(dftY))
grid on;
% e
% original
% sound(x1,Fs);
% filtered
% Normalize Y
Y = Y./(max(abs(Y)));
sound(Y,Fs);
% f
audiowrite('filteredaudio.wav', Y, Fs);
% g
% Movie: Airplane!