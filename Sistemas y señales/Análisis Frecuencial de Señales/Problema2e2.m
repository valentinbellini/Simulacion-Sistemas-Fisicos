[Y, Fs] = audioread('tonos.wav'); % Subida del archivo
N=2^16;
L=(450e-3)*Fs; % Longitud de cada frame
Nframes=length(Y)/L; % N�mero de frames en total
F1000=1000*L/Fs; % Posici�n correspondiente a los 1KHz
F=[0:Fs/L:Fs-Fs/L]';

h = fir1(80,0.325);
H = fft(h,L); %Filtro H de longitud L 

Liminf=0;

for i=1:Nframes
    Limsup=L*i; % L�mite superior de la subdivisi�n
    Yx(:,i)=Y(Liminf+1:Limsup , 1); % Subdivici�n de Y en los frames
    Liminf=L*i; %L�mite inferior de la subdivisi�n
 
    Yfiltrada(:,i)= fft(Yx(:,i)).*H'; % Transformada de las subdiviciones y filtrado
    
    [valor1,pos1]=max((Yfiltrada(1:F1000,i))); % M�ximo antes de los 1KHz
    [valor2,pos2]=max(Yfiltrada(F1000:(L/2),i)); % M�ximo despu�s de los 1KHz
    F1=pos1*Fs/L;
    F2=(pos2+F1000)*Fs/L;
    
    numero(i)=marcado(F1,F2); % N�mero correspondiente a esas frecuencias
    
end

