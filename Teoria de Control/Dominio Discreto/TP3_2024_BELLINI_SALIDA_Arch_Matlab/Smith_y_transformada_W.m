clear
clc
load('data.mat');

%% Modelo del REACTOR BIODIESEL:
s = tf('s');
G = 0.20827 / ((1+98.126*s)*(1+18.916*s));
T_muestreo = 8;
Gz = c2d(G, T_muestreo, 'zoh');
Gz = zpk(Gz);

%% Transformada W
Gw = transfw(Gz);
ps = zero(Gw);
p = ps(1);
Gw_corregida = minreal(Gw/(s-p)); % sacando el polo y ajustando ganancia
K = dcgain(G)/dcgain(Gw_corregida);
Gw_corr = K*Gw_corregida;

%% Calculo Controlador
xi = 0.5;
tr = 110;
wn = 4/(xi*tr);

Gpd = calculoPD(Gw_corr,xi,tr);
Gpi = calculoPI(Gw_corr,Gpd,xi,tr);
Gc = Gpd*Gpi;

% Antitransformada para volver al dominio Z
Gcz = antitransfw(Gc, 8);

figure;
bode(Gpi,Gpd,Gw_corr, Gc*Gw_corr);
legend("Gpi","Gpd","Gw","Gw*Gc");
xlim([10^-3 1]);
grid on;

Gcz_corregido = 60*(z-0.6752)*(z-0.9513)/((z-1)*(z-0.3923));

%% Sistema a lazo cerrado
Glc = (Gw_corr*Gc)/(1+Gw_corr*Gc);
step(Glc);

%% Simulacion
%Gcz = 72.133*(z-0.6752)*(z-0.9713)/((z-1)*(z-0.3923));
sim('CSTR_TP3_2024_2.mdl');
figure;
plot(SP_CE);
hold on;
plot(C_E,'LineWidth', 1.5);
grid on;
xlim([0 1000]);
ylabel('Concentración [mol/L]');
xlabel('Tiempo [s]');
legend('SetPoint','Respuesta Transformada W');
hold off;

%% Comparacion
load('Comparacion.mat');
figure;
plot(SP_CE);
hold on;
plot(Ragazzini, 'LineWidth', 1.5);
plot(SmithW, 'LineWidth', 1.5);
plot(Trapezoidal, 'LineWidth', 1.5);

% Configuración de la gráfica
grid on;
xlim([0 600]);
ylabel('Concentración [mol/L]');
xlabel('Tiempo [s]');
legend('SetPoint', 'Controlador Ragazzini', 'Controlador Transformada W', 'Controlador por Regla Trapezoidal', 'Location', 'best');
hold off;



