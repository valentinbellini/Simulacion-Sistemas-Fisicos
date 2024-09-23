addpath('./Convertidor-Buck/funciones/');

x0 = [0 ; 0];   
t0 = 0;         
tf = 0.01;
h = 2e-7;       

% Aproximacion de Euler
[t1, x1] = feuler(@buck2, x0, h, t0, tf);

% Aproximacion de Heun
[t2, x2] = heun(@buck2, x0, h, t0, tf);


% Ploteo
figure;
subplot(2,1,1);
plot(t1, x1)
title("Simulacion Euler");
legend("uc", "il");
xlabel("t [s]");
grid on;

subplot(2,1,2);
plot(t2,x2);
title("Simulacion Heun");
legend("uc", "il");
xlabel("t [s]");
grid on;
