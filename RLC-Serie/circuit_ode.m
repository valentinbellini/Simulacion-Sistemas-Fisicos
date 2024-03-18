function dx=circuit_ode(x,t)
    F = @(z) circuit_dae(x,z(1:2),z(3:10),t);
    z0=zeros(10,1);
    z=fsolve(F,z0);
    dx=z(1:2);
end