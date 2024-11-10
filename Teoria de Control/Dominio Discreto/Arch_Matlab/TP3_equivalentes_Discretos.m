clear
clc
load('data.mat');

%  ---------- Controlador corregido calculado en TP2 ---------- %
s = tf('s');
J = 140 * ((s+0.0284)*(s+0.012))/(s*(s+0.226));
[z,p,k] = zpkdata(J); % Obtener ceros, polos y ganancia
J_zpk = zpk(z,p,k); % Convertir a formato zpk

% Periodos de muestreo
T_1 = 2.5;
T_2 = 25;

% ------- CALCULO DEL EQUIVALENTE DISCRETO DEL CONTROLADOR J(S) --------- %

Jz_TRR_T1 = c2d(J_zpk, T_1, 'tustin'); % Regla trapezoidal
Jz_FRR_T1 = recadel(J_zpk, T_1); % Regla rectangular por adelanto
Jz_BRR_T1 = recatras(J_zpk, T_1); % Regla rectangular por atraso
Jz_MPZ_T1 = c2d(J_zpk, T_1, 'matched'); % Mapeo de Polos y Ceros
Jz_B0_T1 = c2d(J_zpk, T_1, 'zoh'); % Bloqueador Equivalente orden 0

Jz_TRR_T2 = c2d(J_zpk, T_2, 'tustin');
Jz_FRR_T2 = recadel(J_zpk, T_2);
Jz_BRR_T2 = recatras(J_zpk, T_2);
Jz_MPZ_T2 = c2d(J_zpk, T_2, 'matched');
Jz_B0_T2 = c2d(J_zpk, T_2, 'zoh');

% ----------------------------------------------------------------------- %

% bode(J_zpk, Jz_B0_T1); % Se ve la frec máxima (mitad de frec muestro)


% Obtencion de polos y zeros para cargar controlador en Simulink

[z1,p1,k1] = zpkdata(Jz_TRR_T1);
[z2,p2,k2] = zpkdata(Jz_TRR_T2);

z1 = cell2mat(z1);
z2 = cell2mat(z2);
p1 = cell2mat(p1);
p2 = cell2mat(p2);

z1_1 = z1(1);
z1_2 = z1(2);
z2_1 = z2(1);
z2_2 = z2(2);

p1_1 = p1(1);
p1_2 = p1(2);
p2_1 = p2(1);
p2_2 = p2(2);


% ------------------------- SIMULACION ---------------------------------- %

sim('CSTR_TP3_2024.mdl');
figure;
plot(C_E,'LineWidth', 1.5);
hold on;
plot(SP_CE);
grid on;
hold off;

