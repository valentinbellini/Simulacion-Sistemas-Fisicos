%Carga de la se�al 
load('datosADSL.mat');
Fmax = 1.104e6; %Definicion de la frec maxima
Fs = 2*Fmax; %Frecuencia de muestreo
L = length(datosADSL); %Longitud de la se�al
t = [0:1/Fs:(L-1)/Fs]; %Def tiempo

%Ploteo
subplot(211), plot(t,datosADSL); %Ploteo se�al ADSL
title('Se�al ADSL');
xlabel('Tiempo [s]');
ylabel('Se�al ADSL');
grid on
axis([0 0.625 -200 100])
subplot(212), plot(t,datosADSL); %Ploteo se�al con zoom
title('Se�al ADSL [Zoom]');
xlabel('Tiempo [s]');
ylabel('Se�al ADSL');
grid on
axis([0 0.625 -3 3])

