% Se busca la solución analítica a partir de la función "solvess"
% calculando previamente las matrices A y B a partir de las ecuaciones de
% estado encontradas.

% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

L=1e-4; C=1e-4; R=10;
u=12;
t=[0:1e-5:0.01];
x0=[0 ; 0]; % Condiciones iniciales nulas
% Expresando como x'(t) = Ax(t) + Bu(t) tenemos las matrices:
A=[0 -1/L ; 1/C -1/(R*C)];
B=[1/L ; 0];
xa=solvess(A,B,u,x0,t);

figure
plot(t,xa(1,:))
hold on 
plot(t,xa(2,:))
legend('il','uc')
title('Solucion analitica')
grid on 