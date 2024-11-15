clear;clc;
[y, Fs] = audioread('tonos.wav'); 
N=2^16;
F=[-Fs/2:Fs/N:Fs/2-Fs/N]';

h = fir1(80,0.325); %Filtro pasabajo
Htot = fft(h,N); %Filtro de longitud N (apenas superior a y)

 Y = fft(y,N); % FFT de la señal y con N muestras
 Yfiltrada = Y.*Htot'; % Filtrado de Y

 % Comparación entre señal filtrada, señal sin filtrar y filtro
plot(F,abs(fftshift(Htot)*1500),'r',F,abs(fftshift(Y)),'b',F,abs(fftshift(Yfiltrada)),'k'); 