%Gerar um sinal s(t) composto pela somatoria de 3 senos com
%amplitudes de 6V, 2V e 4V e frequencias de 1, 3 e 5 kHz,
%respectivamente.

A1 = 6;
A2 = 2;
A3 = 4;
%-----------
f1 = 1e3;
f2 = 3e3;
f3 = 5e3;
fs = f1*200;
passo = f1;
freq = [-fs/2:passo:fs/2];
%--------------
Ts = 1/fs;
T = 3*(1/f1);
t = [0:Ts:T];
s = A1*sin(2*pi*f1*t)+A2*sin(2*pi*f2*t)+A3*sin(2*pi*f3*t);
%----------------------------------------------------------
figure(1)
subplot(211)
plot(t, s)
title('Soma de 3 senos com diferentes amplitudes e frequencias')
xlabel('t (milisegundos)')
ylabel('s(t)')
S = fft(s);
subplot(212)
plot(t, S)
title('FFT do sinal s(t)')
xlabel('f(KHz)')
ylabel('S(f)')
%----------------------------
figure(2)
plot(pwelch(s))
title('Densidade espectral de potencia de s')
%------------------------------
potencia_media = norm(s)

