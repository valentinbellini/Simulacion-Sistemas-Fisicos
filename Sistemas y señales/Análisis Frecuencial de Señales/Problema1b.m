tic
%Carga de datos de la señal
load('datosADSL.mat');
L = length(datosADSL);
Fmax = 1.104e6; %Definicion de la frec maxima
Fs = 2*Fmax; %Frecuencia de muestreo
N = 2^21; %Notar que N > L
F=[-Fs/2:Fs/N:Fs/2-Fs/N]'; %Vector de frecuencias
%Transformada de Fourier
X = fft(datosADSL,N);
%Ploteo
figure
plot(F,abs(fftshift(X)));
title('Espectro de Amplitud');
xlabel('Frecuencia [Hz]');
grid on
R = fft(datosADSL);
figure 2
plot(F,abs(fftshitf(R)));
toc