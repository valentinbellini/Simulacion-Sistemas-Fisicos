[Y, Fs] = audioread('tonos.wav'); % Subida del archivo
N=2^16;
L=(450e-3)*Fs; % Longitud de cada frame
Nframes=length(Y)/L; % Número de frames en total
F1000=1000*L/Fs; % Posición correspondiente a los 1KHz
F=[0:Fs/L:Fs-Fs/L]';

h = fir1(80,0.325);
H = fft(h,L); %Filtro H de longitud L 

Liminf=0;

for i=1:Nframes
    Limsup=L*i; % Límite superior de la subdivisión
    Yx(:,i)=Y(Liminf+1:Limsup , 1); % Subdivición de Y en los frames
    Liminf=L*i; %Límite inferior de la subdivisión
 
    Yfiltrada(:,i)= fft(Yx(:,i)).*H'; % Transformada de las subdiviciones y filtrado
    
    [valor1,pos1]=max((Yfiltrada(1:F1000,i))); % Máximo antes de los 1KHz
    [valor2,pos2]=max(Yfiltrada(F1000:(L/2),i)); % Máximo después de los 1KHz
    F1=pos1*Fs/L;
    F2=(pos2+F1000)*Fs/L;
    
    numero(i)=marcado(F1,F2); % Número correspondiente a esas frecuencias
    
end

