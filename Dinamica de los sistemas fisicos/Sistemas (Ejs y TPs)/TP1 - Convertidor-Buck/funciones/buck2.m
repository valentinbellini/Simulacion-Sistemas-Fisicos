
function dx = buck2(x, t)

    L = 1e-4;
    C = 1e-4;
    R = 10;
    Ron = 1e-5; 
    Roff = 1e5;
    T = 1e-4; % Periodo
    dc = 0.5; % Ciclo de Trabajo
    U = 12;
    
    uC = x(1);
    iL = x(2);
    
    r = rem(t, T); %resto de la division entera
    if r < dc*T
        s = 1;
    else
        s = 0;
    end
    
    if s > 0.5
        RS = Ron;
    else
        RS = Roff;
    end
    
    RD = Ron;
        
    % Suponemos inicialmente que el diodo conduce
    iD = (iL - U/RS) / (1 + RD/RS);
    
    % Ahora verificamos
    if iD <= 0
        RD = Roff;
        iD = (iL - U/RS) / (1 + RD/RS);
    end
    
    % Ec de estado:
    der_x1 = (-1/(R*C))*uC + (1/C)*iL;
    der_x2 = (-1/L)*uC - (RD/(L*(1 + RD/RS)))*iL + ((RD/RS)/(L*(1 + RD/RS)))*U;
    
    % Vecor de derivadas
    dx = [der_x1 ; der_x2];
    
end