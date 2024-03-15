% Agregar la carpeta al path
addpath('metodosIntegracion');

% Definir tiempo de simulación
total_time = 15;
h = 0.1;

% Llamar a la función masares    con feuler
[t_feuler, x_feuler] = feuler(@masares, [0; 0], h, 0, total_time);

% Llamar a la función masares con beuler
[t_beuler, x_beuler] = beuler(@masares, [0; 0], h, 0, total_time);

% Configurar gráficos
figure;

% Subplot para feuler
subplot(1, 2, 1);
plot(t_feuler, x_feuler);
xlabel('Tiempo');
ylabel('Posición');
title('Fordward Euler');
grid on;

% Subplot para beuler
subplot(1, 2, 2);
plot(t_beuler, x_beuler);
xlabel('Tiempo');
ylabel('Posición');
title('Backward Euler');
grid on;



function dx=masares(x,t)
    m=1; b=1; k=1; %parametros
    F=1; %entrada
    der_x1=x(2);
    der_x2=-k/m*x(1)-b/m*x(2)+F;
    dx=[der_x1; der_x2]; %vector de derivadas
end
