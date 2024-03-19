% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

L=1e-4; C=1e-4; R=10;
A=[0 -1/L ; 1/C -1/(R*C)];
B=[1/L ; 0];
u=12;
t=[0:1e-5:0.01];
x0=[0 ;0];
solucion=solvess(A,B,u,x0,t);

figure
plot(t,solucion(1,:))
hold on 
plot(t,solucion(2,:))
legend('il','uc')
title('Solucion analitica')
grid on 