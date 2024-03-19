% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

% Condiciones iniciales
x0 = [0 ;0];
% Tiempo inicial y final
t0 = 0;
tf = 0.01;

% Pasos de integracion (array)
h = [1e-5, 1e-6];

% Calcular solución para h = 1e-5
[t1, x1] = feuler(@buck, x0, h(1), t0, tf);
% Calcular solución para h = 1e-6
[t2, x2] = feuler(@buck, x0, h(2), t0, tf);

% Graficar soluciones en subplots
figure;

% Subplot para h = 1e-5
subplot(2, 1, 1);
plot(t1, x1(1, :));
hold on;
plot(t1, x1(2, :));
title(['Método de Euler h = ', num2str(h(1))]);
legend('il', 'uc');
grid on;

% Subplot para h = 1e-6
subplot(2, 1, 2);
plot(t2, x2(1, :));
hold on;
plot(t2, x2(2, :));
title(['Método de Euler h = ', num2str(h(2))]);
legend('il', 'uc');
grid on;

% Calcular errores
Error1 = norm(x1(:,2) - xa(:,2));
Error2 = norm(x2(:,2) - xa(:,2));
disp(['Error para h = 1e-5: ', num2str(Error1)]);
disp(['Error para h = 1e-6: ', num2str(Error2)]);
