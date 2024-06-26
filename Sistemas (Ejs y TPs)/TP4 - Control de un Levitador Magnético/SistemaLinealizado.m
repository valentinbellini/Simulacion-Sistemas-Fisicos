close all

% Datos del sistema
m = 0.02;       % Masa
g = 9.8;        % Aceleración debida a la gravedad
Yo = 9e-3;      % Flujo magnético inicial
Lo = 5.5181e-3; % Inductancia inicial
R = 1;          % Resistencia

% Calcular la corriente de equilibrio
io = sqrt((2 * m * g * Yo) / Lo);

% Sistema de ecuaciones del modelo
A = [-181.2217973421418, 0, -88.83773344788891;
	0, 0, 1;
	24.51077668401418, 2177.505867278755, 0];
B = [181.2217973012815;
	0;
	0];
C = [0, 1, 0];
D = [0];

%Autovalores de la matriz A

fprintf('Autovalores de la Matriz A del sistema linealizado: ');
lambda = eig(A)
fprintf('3 autovalores. 2 con parte real negativa y 1 con parte real positiva\n');
fprintf('Por metodo indirecto de Lyapunov, al tener al menos un autovalor con parte real positiva, el punto de equilibrio es inestable\n');
fprintf('Por HG como no hay autovalor con parte real nula, la trayectoria del punto de equilibrio del sistema linealizado se asemeja a la del no lineal\n\n');

%3 autovalores -> 2 con parte real neg y 1 con parte real positiva
% Por lo tanto por método indirecto de Lyapunov al tener al menos un autovalor con parte 
% real positiva entonces el punto de equilibro es inestable


% Problema 4:
% Crear el sistema en espacio de estados
sys = ss(A, B, C, D);

% Función transferencia del sistema linealizado
fprintf("Función transferencia del sistema linealizado: \n");
G = tf(sys)

% Controlador PID
num = [1/(20^2) 2/20 1];
den = [1 0];
fprintf('Función transferencia del controlador PID:\n');
Gc = tf(num, den) 

%Ft lazo cerrado
fprintf('\nFunción a lazo cerrado con K = 1:\n');
Grel = feedback(G*Gc, 1)
figure;
rlocus(Grel);

% Búsqueda iterativa de K
fprintf('\nSe itera en varios valores de K para encontrar el mínimo valor de cumpla que el tau mas lento sea menor a 60 ms\n');
fprintf('Esto es lo mismo a que la parte real negativa del polo mas cercano al plano complejo, sea mayor a 16.66 (1/60ms)\n');
K_values = logspace(-1, 4, 1000);  % Valores de K en un rango logarítmico
K_opt = 0;  % Inicializar K óptimo
poles_opt = [];  % Inicializar polos óptimos

for K = K_values
    sys_cl = feedback(K * Gc * G, 1);  % Sistema en lazo cerrado con ganancia K
    poles = pole(sys_cl);              % Encontrar los polos del sistema en lazo cerrado
    if all(abs(real(poles)) >  16.67)
        K_opt = K;
        poles_opt = poles;
        break;
    end
end

fprintf('\nValor de K que cumple con la condición: %.5f\n', K_opt);
disp(poles_opt);
figure;
rlocus(feedback(K_opt*G*Gc,1));