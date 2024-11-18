% G:\Mi unidad\UNR Ing electrónica\Materias\8. Teoria de Control\Trabajos Practicos\Trabajo Practico 3\TP Bellini Saitta\Arch_Matlab_TP3_2024-2C
clear
clc
load('data.mat');

%%  ---------- Controlador corregido calculado en TP2 ---------- %
s = tf('s');
J = 140 * ((s+0.0284)*(s+0.012))/(s*(s+0.226));
J_zpk = zpk(J);

%% ------- CALCULO DEL EQUIVALENTE DISCRETO DEL CONTROLADOR J(S) --------- %

% Periodos de muestreo
T_1 = 2.5;
T_2 = 25;

% Equivalente Para T1
Jz_TRR_T1 = c2d(J_zpk, T_1, 'tustin'); % Regla trapezoidal
Jz_FRR_T1 = recadel(J_zpk, T_1); % Regla rectangular por adelanto
Jz_BRR_T1 = recatras(J_zpk, T_1); % Regla rectangular por atraso
Jz_MPZ_T1 = c2d(J_zpk, T_1, 'matched'); % Mapeo de Polos y Ceros
Jz_B0_T1 = c2d(J_zpk, T_1, 'zoh'); % Bloqueador Equivalente orden 0

% Equivalente Para T2
Jz_TRR_T2 = c2d(J_zpk, T_2, 'tustin');
Jz_FRR_T2 = recadel(J_zpk, T_2);
Jz_BRR_T2 = recatras(J_zpk, T_2);
Jz_MPZ_T2 = c2d(J_zpk, T_2, 'matched');
Jz_B0_T2 = c2d(J_zpk, T_2, 'zoh');


%% ----------------------- Graficar polos y ceros ----------------------- %
figure;
pzmap(Jz_TRR_T1, Jz_FRR_T1, Jz_BRR_T1, Jz_MPZ_T1, Jz_B0_T1);
title('Polos y Ceros con T_1 = 2.5 seg');
legend('Trapezoidal', 'Rect. Adelanto', 'Rect. Atraso', 'Mapeo PZ', 'Bloqueador Equivalente');
grid on;

figure;
pzmap(Jz_TRR_T2, Jz_FRR_T2, Jz_BRR_T2, Jz_MPZ_T2, Jz_B0_T2);
title('Polos y Ceros con T_2 = 25 seg');
legend('Trapezoidal', 'Rect. Adelanto', 'Rect. Atraso', 'Mapeo PZ', 'Bloqueador Equivalente');
grid on;

%% Se selecciona para el analisis la integracion por regla trapezoidal
% ----------------------- Graficar polos y ceros ----------------------- %
figure;
pzmap(Jz_TRR_T1);
title('Polos y Ceros con T_1 = 2.5s');
legend('Trapezoidal');
grid on;

figure;
pzmap(Jz_TRR_T2);
title('Polos y Ceros con T_2 = 25s');
legend('Trapezoidal');
grid on;



%% ---------------- Graficar la respuesta en frecuencia ---------------- %
figure;
bode(J_zpk, Jz_TRR_T1, Jz_FRR_T1, Jz_BRR_T1, Jz_MPZ_T1, Jz_B0_T1);
title('Diagrama de Bode con T_1 = 2.5s');
legend('Js - Sistema continuo','Jz - Trapezoidal', 'Jz - Rect Adelanto', 'Jz - Rect Atraso', 'Jz - Mapeo Polos y Ceros', 'Jz - Bloqueador Equivalente');
grid on;

figure;
bode(J_zpk, Jz_TRR_T2, Jz_FRR_T2, Jz_BRR_T2, Jz_MPZ_T2, Jz_B0_T2);
title('Diagrama de Bode con T_2 = 25s');
legend('Js - Sistema continuo','Jz - Trapezoidal', 'Jz - Rect Adelanto', 'Jz - Rect Atraso', 'Jz - Mapeo Polos y Ceros', 'Jz - Bloqueador Equivalente');
grid on;


%% ----- Obtencion de polos y zeros para cargar controlador en Simulink ---%
[z1,p1,k1] = zpkdata(Jz_TRR_T1);

z1 = cell2mat(z1);
p1 = cell2mat(p1);

z1_1 = z1(1);
z1_2 = z1(2);
p1_1 = p1(1);
p1_2 = p1(2);

%% ------------------------- SIMULACION ---------------------------------- %
%open_system('CSTR_TP3_2024.mdl');
set_param('CSTR_TP3_2024/Cont_Disc', 'sw', '0'); % 0 = continuo | 1 = discreto
set_param('CSTR_TP3_2024/T_MUESTREO', 'sw', '0'); % 1 = 2.5 SEG ; 0 = 25 SEG
sim('CSTR_TP3_2024.mdl');
figure;
plot(SP_CE);
hold on;
plot(C_E,'LineWidth', 1.5);
grid on;

% Ajustar la leyenda según los switches
cont_disc = get_param('CSTR_TP3_2024/Cont_Disc', 'sw');
t_muestreo = get_param('CSTR_TP3_2024/T_MUESTREO', 'sw');

if strcmp(cont_disc, '0') && strcmp(t_muestreo, '0')
    legend('SetPoint', 'J(s)');
elseif strcmp(cont_disc, '0') && strcmp(t_muestreo, '1')
    legend('SetPoint', 'J(s)');
elseif strcmp(cont_disc, '1') && strcmp(t_muestreo, '0')
    legend('SetPoint', 'Jz (T = 25seg)');
else
    legend('SetPoint', 'Jz (T = 2.5seg)');
end

title('Respuesta');
xlim([0 1000]);
xlabel('Tiempo');
ylabel('Concentración');
hold off;

%% ------------------------- SIMULACION PRO ------------------------------ %
% Abrir el modelo de Simulink
% open_system('CSTR_TP3_2024.mdl');

% Definir las combinaciones de los switches
combinaciones = {
    '1', '1';
    '1', '0';
    '0', '0'
};

% Inicializar una celda para almacenar los resultados
resultados = cell(size(combinaciones, 1), 1);

% Ejecutar las simulaciones para todas las combinaciones
for i = 1:size(combinaciones, 1)
    % Configurar los switches
    set_param('CSTR_TP3_2024/Cont_Disc', 'sw', combinaciones{i, 1}); % 0 = continuo | 1 = discreto
    set_param('CSTR_TP3_2024/T_MUESTREO', 'sw', combinaciones{i, 2}); % 1 = 2.5 SEG ; 0 = 25 SEG
    
    % Ejecutar la simulación
    sim('CSTR_TP3_2024.mdl');
    
    % Almacenar los resultados
    resultados{i} = struct('SP_CE', SP_CE, 'C_E', C_E, 'cont_disc', combinaciones{i, 1}, 't_muestreo', combinaciones{i, 2});
end

% Graficar los resultados
figure;
hold on;
plot(resultados{1}.SP_CE, 'DisplayName', 'SetPoint'); % Graficar SetPoint una sola vez
plot(resultados{1}.C_E, 'LineWidth', 1.5, 'DisplayName', 'Jz (T = 2.5seg)');
plot(resultados{2}.C_E, 'LineWidth', 1.5, 'DisplayName', 'Jz (T = 25seg)');
plot(resultados{3}.C_E, 'LineWidth', 1.5, 'DisplayName', 'Js');
grid on;

legend;

xlim([0 1000]);
xlabel('Tiempo [s]');
ylabel('Concentración [mol/L]');
hold off;

