
zpi = wn/10;
tpi = 1/zpi;
KPI = wn/sqrt(1+(tpi^2)*(wn^2));

s = tf('s');
GPI = KPI*( (1+tpi*s) / (s) );

T = GPI*GPD*Gpa;
GC_LC = T/(1+T);


figure;
bode(Gpa, 'b');
hold on;
bode(GPD*Gpa, 'g');  % Sistema con corrector PD
bode(GPD*Gpa*GPI, 'm');
legend('Planta','Planta + PD', 'Planta + PID');
title('Diagrama de Bode - Efecto de corrector PD y PID');
grid on;
xlim([10^(-3) 0.4]);  % Establecer el límite en el eje x
hold off;

figure;
step(GC_LC);
grid on;

info = stepinfo(GC_LC);
tr2 = info.SettlingTime;
SV = info.Overshoot;
