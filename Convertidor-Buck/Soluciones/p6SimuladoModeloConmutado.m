% Simular este nuevo sistema usando el metodo de Heun con los siguientes pasos de integracion: 
% h = 2 10−5 ; h = 10−5 y h = 10−6 
% Explicar lo que observa.

% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

x0 = [0 ; 0];
t0 = 0;
tf = 0.01;

% ------ UTILIZANDO HEUN ------
% Pasos de integracion
h = [2e-5 1e-5 1e-6];

figure;
for i = 1:length(h)
    [t, x] = heun(@buck1, x0, h(i), t0, tf);
    % Subplot para el paso h(i)
    subplot(length(h), 1, i);
    plot(t, x(1, :));
    hold on;
    plot(t, x(2, :));
    title(['Método de Heun h = ', num2str(h(i))]);
    legend('il', 'uc');
    grid on;
end

% ------ UTILIZANDO RK23 ------ 
figure;
rtol = 1e-3;
atol = 1e-6;
[t, x] = rk23(@buck1, x0, t0, tf, rtol, atol);
subplot(2,1,1);
plot(t,x(1,:));
hold on;
plot(t,x(2,:));
title(['Método RK23 rtol = ', num2str(rtol)]);
legend('il', 'uc');
grid on;
subplot(2,1,2);
plot(diff(t));
title("Pasos de integracion")

