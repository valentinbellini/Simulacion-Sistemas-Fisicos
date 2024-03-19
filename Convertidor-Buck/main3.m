% Agregar la carpeta al path
addpath('./Convertidor-Buck/funciones/');

t0=0;
tf = 0.01;
h = 1e-5;
x0=[0 ;0];
[t,x]=feuler(@buck,x0,h,t0,tf);

figure
plot(t,x(1,:))
hold on 
plot(t,x(2,:))
legend('il','uc')
title('Metodo de Euler h = 1e-5')
grid on 

Error= norm(x(:,2)-xa1(:,2))
