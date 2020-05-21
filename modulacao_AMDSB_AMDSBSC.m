close all;
clear all;
clc;

%% Modulacao AM-DSB-SC

%definindo o sinal de banda base (que contem informacao)
fm = 1e3;
N = 100;
fs = N*fm;
t_final = 1/fm;
ts = 1/fs;
t = [0:ts:3*t_final];

m = sin(2*pi*fm*t);

%definindo portadora
fc = 20e3;
c = sin(2*pi*fc*t);

s1 = m.*c;

%fazendo as fft dos sinais
M = fft(m)/length(m);
M = fftshift(M);

C = fft(c)/length(c);
C = fftshift(C);

S1 = fft(s1)/length(s1);
S1 = fftshift(S1);

%% Modulacao AM-DSB

s2 = (m + 1.5).*c;

S2 = fft(s2)/length(s2);
S2 = fftshift(S2);

s21 = (m + 0.25).*c;
s22 = (m + 0.5).*c;
s23 = (m + 0.75).*c;
s24 = (m + 1).*c;
s25 = (m + 1.5).*c;

figure(3)
subplot(211)
plot(t, s24)
title('Fator de modulacao = 1')
subplot(212)
plot(t, s25)
title('Fator de modulacao = 1.5')


%% Demodulacao AM-DSB-SC

dem = s1.*c;

filtro = fir1(50, (1500*2)/fs);
%freqz(filtro);
filtrado = conv(dem, filtro);
F = fft(filtrado)/length(filtrado);
F = fftshift(F);

