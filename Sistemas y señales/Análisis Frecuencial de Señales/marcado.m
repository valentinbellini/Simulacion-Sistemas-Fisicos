function  digito  = marcado (F1,F2)

%tabla de frecuencias
FL=[697,770,852,941];
FH=[1209,1336,1477,1633];

%Teclado num�rico
numero=['1',  '2', '3', 'A';
        '4',  '5', '6', 'B';
        '7',  '8', '9', 'C';
        '*',  '0', '#', 'D'];

%Inicializaci�n de filas y columnas
columna=0;
fila=0;

for i=1:4  %  Recorremos las filas del teclado   
    if  ((FL(i)*0.988) < F1) &&  (F1 < (FL(i)*1.018))  % La frecuencia se encuentra dentro del 1.8% de alguna frecuencia nominal
        fila=i; % Encontr� la fila a la que corresponde el n�mero
        
        for j=1:4 % Recorremos las columnas del teclado
            if  ((FH(j)*0.988) < F2)  && (F2 < (FH(j)*1.018))
                columna=j; % encontr� la fila a la que corresponde el n�mero
            end
        end
    end
end

if (columna==0 || fila==0) % Las frecuencia difieren de sus valores nominales m�s de un 1.8% 
    digito='/';
else
    digito=numero(fila,columna); % Encuentro el n�mero
end
end

