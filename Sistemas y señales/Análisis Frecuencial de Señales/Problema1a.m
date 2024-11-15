%Carga de la señal 
load('datosADSL.mat');
Fmax = 1.104e6; %Definicion de la frec maxima
Fs = 2*Fmax; %Frecuencia de muestreo
L = length(datosADSL); %Longitud de la señal
t = [0:1/Fs:(L-1)/Fs]; %Def tiempo

%Ploteo
subplot(211), plot(t,datosADSL); %Ploteo señal ADSL
title('Señal ADSL');
xlabel('Tiempo [s]');
ylabel('Señal ADSL');
grid on
axis([0 0.625 -200 100])
subplot(212), plot(t,datosADSL); %Ploteo señal con zoom
title('Señal ADSL [Zoom]');
xlabel('Tiempo [s]');
ylabel('Señal ADSL');
grid on
axis([0 0.625 -3 3])

