load('datosADSL.mat');
L = length(datosADSL);
Fmax = 1.104e6; %Definicion de la frec maxima
Fs = 2*Fmax; %Frecuencia de muestreo
N = 2^21; %Notar que N > L
F=[-Fs/2:Fs/N:Fs/2-Fs/N]';
X = fft(datosADSL,N);
Y = fftshift(X);