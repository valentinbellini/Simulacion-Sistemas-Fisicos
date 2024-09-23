function dx=circuit_ode(x,t)
    q=x(1); phi=x(2); %estados
    R=1; L=1; C=1; %parametros
    v=sin(t); %entrada
    der_q=phi/L;
    der_phi=-q/C-R/L*phi+v;
    dx=[der_q; der_phi]; %vector de derivadas
end