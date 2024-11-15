load('datosADSL.mat');
L = length(datosADSL); %Longitud de la señal ADSL
Fmax = 1.104e6; %Definicion de la frec maxima
Fs = 2*Fmax; %Frecuencia de muestreo
N = 2^21; %Notar que N > L
F=[-Fs/2:Fs/N:Fs/2-Fs/N]';
X = fft(datosADSL,N); %Transformada de Fourier
Y = fftshift(X);

% % ceil() rounds to the next higher integer, in the +infinity direction.
% % floor() rounds to the next lower integer, in the -infinity direction.

%Filtro de voz
k1 = ceil(300*N/Fs);
k2 = floor(3400*N/Fs);
Hvoz = zeros(N,1);
Hvoz(k1:k2) = 1;
Hvoz(N-k2:N-k1) = 1;

% Filtro de Upstream
k3 = ceil(25875*N/Fs);
k4 = floor(138e3*N/Fs);
Hup = zeros(N,1);
Hup(k3:k4) = 1;
Hup(N-k4:N-k3) = 1;

% %Filtro de Downstream
k5 = ceil(138e3*N/Fs);
k6 = floor(1.104e6*N/Fs);
Hdown = zeros(N,1);
Hdown(k5:k6) = 1;
Hdown(N-k6:N-k5) = 1;

% %Ploteo del filtro H
% subplot(311), plot(F,fftshift(Hvoz),'r','LineWidth',1.5);
% title('Filtros de la señal ADSL para cada componente');
% subplot(312), plot(F, fftshift(Hup),'r','LineWidth',1.5);
% subplot(313), plot(F,fftshift(Hdown),'r','LineWidth',1.5);
% xlabel('Frecuencia [Hz]');

%Señales filtradas
Svoz = X.*Hvoz; %Señal de voz filtrada
Sup = X.*Hup; %Señal de Upstream filtrada
Sdown = X.*Hdown; %Señal de Downstream filtrada

%Ploteo señales filtradas
figure (2)
subplot(311), plot(F,fftshift(abs(Svoz)));
title('Componentes filtradas')
axis([-3500 3500 0 2500])
ylabel('Señal de voz');
subplot(312), plot(F, fftshift(abs(Sup)));
ylabel('Señal upstream');
subplot(313), plot(F,fftshift(abs(Sdown)));
ylabel('Señal downstream');
xlabel('Frecuencia [Hz]');

%Reproducir señal de audio.
t = [0:1/Fs:(L-1)/Fs]; %Def tiempo
VozFiltrada = real(ifft(Svoz));
Vozresample = resample(VozFiltrada, 6800,Fs);

soundsc(Vozresample,6800);


