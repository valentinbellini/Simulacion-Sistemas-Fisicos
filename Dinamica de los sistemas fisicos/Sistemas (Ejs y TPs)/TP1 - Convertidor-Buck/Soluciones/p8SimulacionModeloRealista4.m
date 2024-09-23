addpath('./Convertidor-Buck/funciones/');

x0 = [0 ; 0];   
t0 = 0;         
tf = 0.01;
rtol = 1e-3;    % Tolerancia Relativa
atol = 1e-6;    % Tolerancia Absoluta  

% Aproximacion rk23
[t, x] = rk23(@buck2, x0, t0, tf, rtol, atol);

figure;
plot(t,x(1,:));
hold on;
plot(t, x(2, :));
title(['Método RK23 rtol = ', num2str(rtol)]);
legend('il', 'uc');
grid on;