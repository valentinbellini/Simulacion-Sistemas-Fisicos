% Solvess calcula la solución del sistema de ecuaciones diferenciales
% lineales x' = Ax + Bu utilizando el método de la matriz exponencial. Devuelve la evolución temporal 
% del estado del sistema x(t) para cada punto de tiempo especificado en el
% vector t

function x=solvess(A,B,u,x0,t)
    n=length(x0);
    N=length(t);
    I=eye(n,n);
    x=zeros(n,N);
    for k=1:N
        x(:,k)=expm(A*t(k))*x0 + inv(A)*(expm(A*t(k)) - I)*B*u;
    end
end

% la función devuelve una matriz x donde cada columna representa el estado del sistema 
% en un punto de tiempo dado, y cada fila representa una variable de estado.
    