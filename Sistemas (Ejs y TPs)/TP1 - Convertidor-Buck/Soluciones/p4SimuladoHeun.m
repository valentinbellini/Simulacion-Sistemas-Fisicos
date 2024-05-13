% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

% Condiciones iniciales
x0 = [0 ;0];
% Tiempo inicial y final
t0 = 0;
tf = 0.01;

% Pasos de integracion
h = [1e-4 1e-5 2e-5];

figure; 
for i = 1:length(h)
    % Calcular solución para el paso h(i)
    [t, x] = heun(@buck, x0, h(i), t0, tf);
    % Subplot para el paso h(i)
    subplot(length(h), 1, i);
    plot(t, x(1, :));
    hold on;
    plot(t, x(2, :));
    title(['Método de Heun h = ', num2str(h(i))]);
    legend('il', 'uc');
    grid on;
end