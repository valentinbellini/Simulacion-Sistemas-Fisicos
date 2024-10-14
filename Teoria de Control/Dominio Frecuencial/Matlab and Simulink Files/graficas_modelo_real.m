
K_seguridad = 1;
G_c_ajustado = GCC;


% Creación de una figura con dos subplots
figure;

% Subplot 1: Respuesta a cambio de setpoint
subplot(2,1,1);
plot(C_E, 'LineWidth', 1.5);
hold on;
plot(SP_CE, 'k--');
hold on;
set_point = mean(SP_CE);
line([0, max(C_E)], [set_point * 0.98, set_point * 0.98], 'Color', 'r', 'LineStyle', '--');
line([0, max(C_E)], [set_point * 1.02, set_point * 1.02], 'Color', 'r', 'LineStyle', '--');

legend('CE', 'Set Point');
title('Respuesta a Cambio de Set Point en 2% - K Seguridad al 100%');
xlabel('Tiempo');
ylabel('CE');
grid on;

% Subplot 2: Ploteo de "F_h"
subplot(2,1,2);
plot(F_h, 'r', 'LineWidth', 1.5);
title('Variable Manipulada F_h');
xlabel('Tiempo');
ylabel('Fh');
grid on;

% Ajustar los ejes en ambos subplots (opcional)
xlim([0 500]);

hold off;


