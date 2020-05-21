close all;
clear all;
clc;

%% Gerando 3 cossenos com freq de 1, 2 e 3 KHz

f1 = 1e3;
f2 = 2e3;
f3 = 3e3;
N = 100;
fs = N*f1;
t_final = 1/f1;
t = [0:1/fs:3*t_final];
freq = [-fs/2:1/t_final:fs/2];

m1 = cos(2*pi*f1*t);
m2 = cos(2*pi*f2*t);
m3 = cos(2*pi*f3*t);
 
%% Realizando a multiplexacao

c1 = cos(2*pi*10e3*t);
c2 = cos(2*pi*12e3*t);
c3 = cos(2*pi*14e3*t);

s1 = m1.*c1;
s2 = m2.*c2;
s3 = m3.*c3;
S1 = fftshift(fft(s1)/length(s1));
S2 = fftshift(fft(s2)/length(s2));
S3 = fftshift(fft(s3)/length(s3));

% demonstrando o sinal com sobreposicao de frequencias
mult = s1 + s2 + s3;
MULT = fftshift(fft(mult)/length(mult));

% Gerando os filtros passa-faixas
FPF1 = fir1(100, [((10500*2)/fs) ((11500*2)/fs)], 'bandpass');
FPF2 = fir1(100, [((13500*2)/fs) ((14500*2)/fs)], 'bandpass');
FPF3 = fir1(100, [((16500*2)/fs) ((17500*2)/fs)], 'bandpass');

mod1 = conv(s1, FPF1);
mod2 = conv(s2, FPF2);
mod3 = conv(s3, FPF3);
multiplexado = mod1 + mod2 + mod3;
M = fft(multiplexado)/length(multiplexado);
M = fftshift(M);

%% recuperacao do sinal 

demod1 = conv(multiplexado, FPF1);
demod2 = conv(multiplexado, FPF2);
demod3 = conv(multiplexado, FPF3);
DEMOD1 = fftshift(fft(demod1)/length(demod1));
DEMOD2 = fftshift(fft(demod2)/length(demod2));
DEMOD3 = fftshift(fft(demod3)/length(demod3));

% aumentando o tamanho do vetor da portadora para poder fazer a
% multiplicacao com o sinal demod's
c1(501) = 0;
c2(501) = 0;
c3(501) = 0;
rec1 = demod1.*c1;
rec2 = demod2.*c2;
rec3 = demod3.*c3;
REC1 = fftshift(fft(rec1)/length(rec1));
REC2 = fftshift(fft(rec2)/length(rec2));
REC3 = fftshift(fft(rec3)/length(rec3));

FPB1 = fir1(50, (1000*2)/fs);
FPB2 = fir1(50, (2000*2)/fs);
FPB3 = fir1(50, (3000*2)/fs);

out1 = conv(rec1, FPB1);
out2 = conv(rec2, FPB2);
out3 = conv(rec3, FPB3);


