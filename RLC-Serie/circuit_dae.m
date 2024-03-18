function res=circuit_dae(x,dx,a,t)
    R=1; C=1; L =1; %parametros
    q=x(1); phi=x(2); %estados
    der_q=dx(1); der_phi=dx(2); %derivadas de estados
    uR=a(1); iR=a(2); iC=a(3); uC=a(4); uL=a(5); iL=a(6); uS=a(7); iS=a(8);
    res=zeros(10,1); %residuo (debera ser cero)
    res(1) = uR - R * iR;
    res(2) = der_q - iC;
    res(3) = q - C * uC;
    res(4) = der_phi - uL;
    res(5) = phi - L * iL;
    res(6) = uS - sin(t);
    res(7) = uL + uR + uC - uS;
    res(8) = iL - iR;
    res(9) = iC - iL;
    res(10) = iS - iR;
end