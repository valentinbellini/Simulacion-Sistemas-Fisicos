function dx=buck1(x,t)
    L=1e-4; C=1e-4; R=10; %parametros
    U=12;  %entrada
    iL=x(1);
    uC=x(2);
    T=1e-4 ; dc=0.5; %periodo y ciclo de trabajo
    r=rem(t,T); %resto de la division entera entre el tiempo y el periodo
    if r < dc*T
        s=1;
    else
        s=0;
    end
    der_x1=-(1/L)*uC+(1/L)*(U*s);
    der_x2=(1/C)*iL-(1/(R*C))*uC;
    dx=[der_x1; der_x2]; %vector de derivadas
end