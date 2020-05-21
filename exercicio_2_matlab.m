%Gerar um sinal s(t) composto pela somat?ria de 3 senos com amplitudes
%de 5V, 5/3V e 1V e frequ?ncias de 1, 3 e 5 kHz, respectivamente.

A1 = 5;
A2 = 5/3;
A3 = 1;

f1 = 1e3;
f2 = 3e3;
f3 = 5e3;

fs = f1*50; %50K
Ts = 1/fs;
T = 1/f1;

t=[0:Ts:3*T];
passo = 1/(3*T);
freq = [-fs/2:passo:fs/2];

s = A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
S = fft(s)/length(s);

% subplot(211)
% plot(t, s)
% title('Soma de 3 senos com diferentes amplitudes e frequencias')
% xlabel('t(milisegundos)')
% ylabel('s(t)')
% subplot(212)
% plot(freq, S)
% title('FFT do sinal s(t)')
% xlabel('f(KHz)')
%  ylabel('S(f)')

% projetando os filtros
filtro_PB = fir1(50,(2000*2)/fs, 'low'); %(2000*2)/fs 0.08
filtro_PF = fir1(50,[(2000*2)/fs (4000*2)/fs], 'bandpass'); %(2000*2)/fs (4000*2)/fs 0.08 0.16
filtro_PA = fir1(50,(4000*2)/fs, 'high'); %(4000*2)/fs 0.16

filtrado_PB = conv(filtro_PB, s);
filtrado_PF = conv(filtro_PF, s);
filtrado_PA = conv(filtro_PA, s);

PB = fft(filtrado_PB)/length(filtrado_PB);
PF = fft(filtrado_PF)/length(filtrado_PF);
PA = fft(filtrado_PA)/length(filtrado_PA);

figure(1)
subplot(211)
plot(filtrado_PB)
title('Sinal filtrado pelo filtro passa baixas')
subplot(212)
plot(abs(fftshift(PB)))
title('FFT do sinal filtrado')


figure(2)
subplot(211)
plot(filtrado_PF)
title('Sinal filtrado pelo filtro passa faixa')
subplot(212)
plot(abs(fftshift(PF)))
title('FFT do sinal filtrado')



figure(3)
subplot(211)
plot(filtrado_PA)
title('Sinal filtrado pelo filtro passa altas')
subplot(212)
plot(abs(fftshift(PA)))
title('FFT do sinal filtrado')

% figure(1)
% freqz(filtro_PB)
% figure(2)
% freqz(filtro_PF)
% figure(3)
% freqz(filtro_PA)

