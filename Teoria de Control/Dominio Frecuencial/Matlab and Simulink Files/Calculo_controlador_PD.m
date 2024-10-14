% Funcion transferencia planta
s = tf('s');
Gpa = (0.20827/((98.126*s+1)*(18.916*s+1)))*exp(-8*s);

% Condiciones dinámicas
condicion_tr2 = 110;
condicion_SV = 0.20;

% Suponiendo sistema de segundo orden
%xi = -log(condicion_SV) / sqrt(pi^2 + log(condicion_SV)^2); 
%wn = 4/(xi*condicion_tr2);
%MF = 100*xi;
xi = 0.46;
wn = 0.08;
MF = 46;

% Resultado de magnitud y fase para dicha frecuencia
[mag,phase]=bode(Gpa,wn);

% Conversiones
mag_db = 20*log10(mag);

% Cálculo de parametros para el controlador
% phi_m = MF - (180+phase);
phi_m = 50.95;
phi_m_rad = deg2rad(phi_m);

a = (sin(phi_m_rad) + 1) / (1 - sin(phi_m_rad));
tau = 1/(wn*sqrt(a));
KPD = (1/(mag*sqrt(a))) * 1;
GPD = KPD*((1 + a*tau*s) / (1 + tau*s));

GPD_LC = (GPD*Gpa)/(1+GPD*Gpa);
step(GPD_LC);
grid on;

figure;
hold on;
bode(Gpa, 'b');  % Planta original sin correctores
bode(GPD,'m');
bode(GPD*Gpa, 'r');  % Sistema con corrector PD
legend('LA sin corrector', 'Corrector GPD(s)','LA con corrector PD');
title('Diagrama de Bode - Efecto de corrector PD');
grid on;

figure;
bode(GPD,'b');
title('Diagrama de Bode - Corrector PD');
grid on;


figure;
margin(Gpa*GPD);
grid on;


