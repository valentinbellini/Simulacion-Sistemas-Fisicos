% Programar en Octave o Matlab una función que permita evaluar la derivada del vector de estados
% en función del estado y del tiempo. Considerar por el momento en dicha función que la llave está
% cerrada todo el tiempo. Ayuda: Puede usar como modelo la función dada por el Código 3 que
% evalua la derivada del vector de estados para un sistema masa-resorte

function dx=masares(x,t)
    m=1; b=1; k=1; %parametros
    F=1; %entrada
    der_x1=x(2);
    der_x2=-k/m*x(1)-b/m*x(2)+F;
    dx=[der_x1; der_x2]; %vector de derivadas
    end