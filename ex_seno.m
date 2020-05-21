clc
clear all
f = 1e3; %frequencia do seno
N = 200; %fator de super amostragem
fs = N*f; %frequencia de amostragem
num_periodo = 4; %num periodos amostrados na tela
t_final = num_periodo*(1/f);
Ts = 1/fs; %espa?o entre as amostras (tempo de amostragem)
t = [0:Ts:t_final-Ts]; %subtraindo o Ts pois ? sera a primeira amostra do 3 periodo
y = sin(2*pi*f*t)+3*sin(2*pi*2*f*t);
plot(t, y)
axis([0 5/f -5 5]) %definindo janela de visualizacao