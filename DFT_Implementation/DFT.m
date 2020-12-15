% roshan shrestha
% implement DFT

clc
clear
close all

N = 1028;
format long;

% read file signal.txt
file = fopen('correctsignal.txt', 'r');
dataFormat = '%f';
xn = fscanf(file, dataFormat);
fclose(file);

% plot
x = 1:N;
x = x';
y = xn(x);
figure(1), subplot(2,3,1), stem(x,y), ylabel('x[n]'), xlabel('n'), title('Signal x[n]')

% calculate the 1028-point DFT of the signal x[n]
x1 = [];
%%
% 
%   for x = 1:10
% 
%   for x = 1:10
%       disp(x)
%   end
% 
%       disp(x)
%   end
% 
for k = 0:N-1
    temp = 0;
    for n = 0:N-1
        temp = temp + xn(n+1)*exp(1j*2*pi*n*k/N);
    end
    x1 = [x1 temp];
end

x1 = x1';

% plot magnitude and phase of x1k
figure(1), subplot(2,3,2), plot(x, abs(x1)), ylabel('Magnitude'), xlabel('n'), title('Magnitude plot x1')
figure(1), subplot(2,3,3), plot(x, angle(x1)), ylabel('Phase'), xlabel('n'), title('Phase plot x1')

% using MATLAB fft()
x2 = fft(xn);
% plot magnitude and phase of x1k
figure(1), subplot(2,3,5), plot(x, abs(x2)), ylabel('Magnitude'), xlabel('n'), title('Magnitude plot x2')
figure(1), subplot(2,3,6), plot(x, angle(x2)), ylabel('Phase'), xlabel('n'), title('Phase plot x2')

