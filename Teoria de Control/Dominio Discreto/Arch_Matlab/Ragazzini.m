clear
clc
load('data.mat');

% Modelo del REACTOR BIODIESEL:
s = tf('s');
G =  ( 0.20827 / ((1+98.126*s)*(1+18.916*s)) ) * exp(-8*s);
T_muestreo = 8;
Gz = c2d(G, T_muestreo, 'zoh'); % Bloqueador Equivalente orden 0

% Especificaciones dinamicas a lazo cerrado -> Buscar H(z) que cumpla
SV = 0.20; % SV = exp(-(pi*xi)/sqrt(1-xi^2))
tr = 110; % tr al 2%
e01 = 0;

% Utilizamos aproximaciones para encontrar la FT que cumpla los requisitos
xi = 0.5; % 0.456;
wn = 4/(xi*tr);
r = exp(-xi*wn*T_muestreo);
theta = wn*T_muestreo*sqrt(1-xi^2);
Hz_den = [1, -2*r*cos(theta), r^2];

% Cálculo de denominador
b1 = ( 1-2*r*cos(theta)+r^2 );
Hz_num = [b1];
Hz = tf(Hz_num, Hz_den, T_muestreo);

% Verifica causalidad y estabilidad
Gz.inputDelay = 0;
Dz = Hz / (Gz * (1 - Hz));  % Calcula D(z)
Gz.inputDelay = 1;
Dz = zpk(minreal(Dz)); % Para cancelar los polos y ceros iguales

% sys_cl = feedback(Dz * Gz, 1);  % Sistema en lazo cerrado
%step(sys_cl); % Simulación de respuesta al escalón


% ------------------------- SIMULACION ---------------------------------- %
sim('CSTR_TP3_2024_2.mdl');
figure;
plot(C_E,'LineWidth', 1.5);
hold on;
plot(SP_CE);
grid on;
hold off;


