function [x_next, v_next] = backward_euler_step(x_prev, v_prev, m, k, b, F, h)
    % Función que define la ecuación a resolver
    function [f_x, f_v] = backward_euler_equation(x_next, x_prev, v_prev, m, k, b, F, h)
        f_x = x_next - x_prev - h * v_next;
        f_v = v_next - v_prev - (F - k * x_next - b * v_next) / m * h;
    end

    % Aproximación inicial para la posición y la velocidad
    x_next = x_prev + h * v_prev;
    v_next = v_prev + (F - k * x_next - b * v_prev) / m * h;

    % Resolver la ecuación iterativamente usando el método de Newton-Raphson
    for iter = 1:10  % Realizar 10 iteraciones
        [dx, dv] = backward_euler_equation(x_next, x_prev, v_prev, m, k, b, F, h);
        x_next = x_next - dx;
        v_next = v_next - dv;
    end
end

function [t_values, x_values] = sistema_masa_resorte(m, k, b, F_func, h, total_time, method)
    num_steps = total_time / h;  % Número de pasos de tiempo
    t_values = zeros(1, num_steps);   % Array para almacenar los tiempos
    x_values = zeros(1, num_steps);   % Array para almacenar las posiciones
    v_values = zeros(1, num_steps);   % Array para almacenar las velocidades

    % Condiciones iniciales
    x_values(1) = 0.0;  % Posición inicial
    v_values(1) = 0.0;  % Velocidad inicial

    for i = 2:num_steps
        t = (i - 1) * h;  % Tiempo actual

        % Fuerza externa
        F = F_func(t);

        % Aplicar un paso de Euler según el método elegido
        if method == 0
            [x_values(i), v_values(i)] = backward_euler_step(x_values(i - 1), v_values(i - 1), m, k, b, F, h);
        else
            [x_values(i), v_values(i)] = forward_euler_step(x_values(i - 1), v_values(i - 1), m, k, b, F, h);
        end

        % Almacenar el tiempo actual
        t_values(i) = t;
    end
end

function [x_next, v_next] = forward_euler_step(x_prev, v_prev, m, k, b, F, h)
    % Calcular la aceleración usando la segunda ley de Newton
    a = (F - k * x_prev - b * v_prev) / m;

    % Actualizar la velocidad y la posición usando el método de Euler hacia adelante
    v_next = v_prev + a * h;
    x_next = x_prev + v_prev * h;
end

% Función para la fuerza externa constante
function F = F_constante(t)
    F = 1.0;
end

% Parámetros del sistema
m = 1.0;  % Masa
k = 1.0;  % Constante del resorte
b = 1.0;  % Coeficiente de fricción
total_time = 13.0;  % Tiempo total de simulación
h_values = [0.01, 0.25, 0.5, 0.75, 1.0];  % Valores de h que deseas probar

figure;
% Simular y graficar el sistema para cada valor de h
for i = 1:length(h_values)
    h = h_values(i);
    [t_values, x_values] = sistema_masa_resorte(m, k, b, @F_constante, h, total_time, 0); % backward_euler_step
    [t_values_2, x_values_2] = sistema_masa_resorte(m, k, b, @F_constante, h, total_time, 1); % forward_euler_step
    subplot(2, 1, 1);
    plot(t_values, x_values, 'DisplayName', ['h = ', num2str(h)]);
    hold on;
    subplot(2, 1, 2);
    plot(t_values_2, x_values_2, 'DisplayName', ['h = ', num2str(h)]);
    hold on;
end

% Configuraciones adicionales del gráfico
subplot(2, 1, 1);
title('Using Backward Euler Step');
xlabel('Time');
ylabel('Position');
legend;
grid on;

subplot(2, 1, 2);
title('Using Fordward Euler Step');
xlabel('Time');
ylabel('Position');
legend;
grid on;

sgtitle('Simulación de un sistema masa-resorte con fuerza externa constante');
