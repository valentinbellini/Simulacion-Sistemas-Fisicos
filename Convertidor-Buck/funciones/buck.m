% Función que permita evaluar la derivada del vector de estados en función del estado y del tiempo. 
% En este codigo se modela dx para el caso simplificado del circuito buck.

function dx=buck(x,t)
    L=1e-4; C=1e-4; R=10; %parametros
    U=12;  %entrada
    iL=x(1);
    uC=x(2);
    der_x1=(1/L)*U -(1/L)*uC ;
    der_x2=(1/C)*iL-(1/(R*C))*uC;
    dx=[der_x1; der_x2]; %vector de derivadas
end