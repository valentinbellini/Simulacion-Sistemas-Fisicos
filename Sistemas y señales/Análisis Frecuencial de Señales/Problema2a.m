clear;clc;
%muestra-Frecuencia de muestreo
[Y, Fs] = audioread('tonos.wav');  
L=length(Y); %Longitud total de 'tonos.wav' una vez muestreada
N=2^16; % N > L
F=[-Fs/2:Fs/N:Fs/2-Fs/N]';
X=fft(Y,N); %Transformada de Fourier rápida con N muestras

%Ploteo
plot(F,abs(fftshift(X)));
title('Espectro de Amplitud');
xlabel('Frecuencia [Hz]');