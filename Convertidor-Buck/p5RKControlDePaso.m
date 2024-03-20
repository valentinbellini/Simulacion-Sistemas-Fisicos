% Utilizar tolerancias relativa y absoluta rtol = 10−3, atol = 10−6
% Graficar los resultados y calcular numero de pasos que realiza el metodo (length(t)). 
% Graficar tambien el tamaño del paso h(plot(diff(t))).
%  Repetir el punto anterior para tolerancias relativa y absoluta rtol = atol = 10−6

% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

% Condiciones iniciales
x0 = [0 ;0];
% Tiempo inicial y final
t0 = 0;
tf = 0.01;

rtol = [1e-3 1e-6];
atol = 1e-6;

figure;
for i = 1:length(rtol)
    [t, x] = rk23(@buck, x0, t0, tf, rtol(i), atol);
    
    % Subplot para las variables de estado
    subplot(length(rtol),2,2*i-1);
    plot(t, x(1,:));
    hold on;
    plot(t, x(2,:));
    title(['RK23 con rtol = ', num2str(rtol(i)), ', Número de pasos [ len(t) ] = ', num2str(length(t))]);
    legend('ic','ul');
    grid on;
    
    % Calcular el tamaño del paso h
    h = diff(t);
    
    % Subplot para el tamaño del paso h
    subplot(length(rtol),2,2*i);
    plot(t(1:end-1), h); % diff() calcula la diferencia entre elementos consecutivos de un vector. Se obtiene un elemento menos.
    title(['Tamaño del paso h para rtol = ',num2str(rtol(i))]);
    xlabel('Tiempo');
    ylabel('Tamaño del paso h');
    grid on;
end
