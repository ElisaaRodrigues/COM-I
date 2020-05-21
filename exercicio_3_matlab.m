close all
clear all
clc

fs = 10e3; 
T = 1/fs;
t = [0:T:10000];
f = [-fs/2:fs:fs/2];

ruido = randn(1, 10000);
% histogram(ruido)
% title('Histograma do ruido original')
R = fftshift(fft(ruido)/length(ruido));
% figure(2)
% subplot(211)
% plot(ruido)
% title('Plot do ruido no tempo')
% xlim([0 80])
% subplot(212)
% plot(abs(R))
% title('Plot do ruido na frequencia')
% xlim([0 80])

correlacao = xcorr(ruido);
% figure(3)
% plot(correlacao)
% title('Funcao autocorrelacao do ruido')

filtro = fir1(50, (1000*2)/fs);
% freqz(filtro)
% title('Resposta em frequencia do filtro passa-baixas')


filtrado = conv(filtro, ruido);
F = fftshift(fft(filtrado)/length(filtrado));
% figure(4)
% subplot(211)
% plot(filtrado)
% title('Plot do ruido filtrado no tempo')
% xlim([0 80])
% subplot(212)
% plot(abs(F))
% title('Plot do ruido filtrado na frequencia')
% xlim([0 80])

histogram(filtrado)
title('Histograma do ruido filtrado')