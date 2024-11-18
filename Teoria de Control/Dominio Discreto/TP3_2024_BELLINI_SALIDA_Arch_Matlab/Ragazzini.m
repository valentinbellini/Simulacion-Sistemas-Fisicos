clear
clc
load('data.mat');

%% Modelo del REACTOR BIODIESEL:
s = tf('s');
T_muestreo = 8;
z = tf('z',T_muestreo);
G =  ( 0.20827 / ((1+98.126*s)*(1+18.916*s)) ) * exp(-8*s);
Gz = zpk(c2d(G, T_muestreo, 'zoh')); % Bloqueador Equivalente orden 0

%% Especificaciones dinamicas a lazo cerrado -> Buscar H(z) que cumpla
SV = 0.20; % SV = exp(-(pi*xi)/sqrt(1-xi^2))
tr = 110; % tr al 2%
e01 = 0;

%% Diseño de controlador de Ragazzini
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
% Dz = Hz / (Gz * (1 - Hz));  % Calcula D(z)
Dz = (Hz/(1-Hz))*(z/Gz); % Calcula Dz agregando al inputDelay en forma manual
Gz.inputDelay = 1;
Dz = zpk(minreal(Dz)); % Para cancelar los polos y ceros iguales

Gz.inputDelay = 1;
%%
figure;
sys_cl = feedback(Dz * Gz, 1);  % Sistema en lazo cerrado
step(sys_cl); % Simulación de respuesta al escalón


%% ------------------------- NUEVA HZ ---------------------------------- %

Gz_zero = zero(Gz); % Zero cerca de 1 que genera oscilaciones
syms b0 b1 % Propongo un nuevo numerador para H2(z) : b0 + b1 z^-1

eq1 = b0 + (b1/Gz_zero) == 0; % Condicion para cancelar el cero de G(z)
eq2 = (b0 + b1)/(1 -2*r*cos(theta) + r^2) == 1; % ess = 0 si H(z=1)=1
rta = solve([eq1, eq2], [b0,b1]); % Resolucion del sistema de ecuaciones
Hz_2 = (double(rta.b0) + double(rta.b1)*z^-1)*tf(1,Hz_den,T_muestreo); % Nueva funcion a lazo cerrado H(z)

Gz.inputDelay = 0;
C_z = (z/Gz)* (Hz_2/(1-Hz_2));
Cz = zpk(minreal(C_z)); % cancelo polos y ceros
Dz_2 = Cz;

Gz.inputDelay = 1;
%%
figure;
sys_cl_2 = feedback(Dz_2 * Gz, 1);  % Sistema en lazo cerrado
step(sys_cl_2); % Simulación de respuesta al escalón

%% ------------------------- SIMULACION ---------------------------------- %
sim('CSTR_TP3_2024_2.mdl');
figure;
plot(SP_CE);
hold on;
plot(C_E,'LineWidth', 1.5);
grid on;
xlim([0 1000]);
ylabel('Concentración [mol/L]');
xlabel('Tiempo [s]');
legend('SetPoint','Respuesta Ragazzini');
hold off;

