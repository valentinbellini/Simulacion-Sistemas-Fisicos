clear
clc

% Definicion de funciones transferencia
s = tf('s');
% Gpa: FT aproximada de la planta
Gpa = (0.20827/((98.126*s+1)*(18.916*s+1)))*exp(-8*s);
Gpa_lc = Gpa/(1+Gpa);

% GPD: FT del corrector PD
GPD = 24.4395 *((1 + 35.25*s) / (1 + 4.4326*s));
GPD_LC = GPD*Gpa/(1+GPD*Gpa);

% GPI: FT del corrector PI
GPI = 0.008 *((1+125*s)/s);

% GPID: FT Planta + Corrector PD + Corrector PI
G_PID = GPD*GPI;
GPID = G_PID*Gpa;
GPID_LC = GPID/(1+GPID);

% GCC: FT del PID Corregido
GCC = 140*((s+0.0284)*(s+0.012)/(s*(s+0.226)));
GCC_LC = GCC*Gpa/(1+GCC*Gpa);


figure;
hold on;
step(GPD_LC);
step(GPID_LC);
step(GCC_LC);
grid on;
legend('Control PD','Control PID','Control PID Corregido');
title('Respuesta al escal�n para los distintos controladores');
hold off;
xlim([0 250]);