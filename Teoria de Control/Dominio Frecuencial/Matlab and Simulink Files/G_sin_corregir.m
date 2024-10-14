clear
clc

% Funcion transferencia
s = tf('s');
Gpa = (0.20827/((98.126*s+1)*(18.916*s+1)))*exp(-8*s);
Gpa_sr = 0.20827 / ((98.126*s+1)*(18.916*s+1));

% Sistema en lazo cerrado con realimentacion unitaria
Gpa_lc = Gpa/(1+Gpa);
Gpa_sr_lc = Gpa_sr/(1+Gpa_sr);

% Graficar la respuesta al escalon del sistema en lazo cerrado con
% realimentacion unitaria
figure;
step(Gpa_lc);
title('Respuesta al escalon del sistema en lazo cerrado');
grid on;

% Calcular el error en estado estacionario
Kp = dcgain(Gpa);  % Ganancia estatica
ess = 1/(1 + Kp);  % Error en estado estacionario

info = stepinfo(Gpa_lc);
tr2 = info.SettlingTime;
SV = info.Overshoot;

% Calcular margenes de estabilidad
[GM, PM, Wcg, Wcp] = margin(Gpa); 
figure;
margin(Gpa);
grid on;


% figure;
% hold on;
% bode(Gpa_r);
% hold on;
% bode(Gpa);
% legend('GPA SIN RETARDO','GPA ORIGINAL');

