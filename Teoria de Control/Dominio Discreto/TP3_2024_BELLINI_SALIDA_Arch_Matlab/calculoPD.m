function [Gpd]=calculoPD(Gw,xi,tr)
s = tf('s');
wn = 4/(xi*tr);
w0 = wn;
[mag,phase] = bode(Gw,w0); % w0 = wn
MF = 100*xi;

Df = MF-(180-(360-phase)); % Diferencia de fase
phim = Df*pi/180; % Desfasaje maximo igual al avance requerido
a = (1+sin(phim))/(1-sin(phim));
tau = 1/(w0*sqrt(a));
Zpd = 1/(a*tau); % Cero del PD
Ppd = 1/tau;  %Polo del PD
Gpd1 = tf((1+s/Zpd)/(1+s/Ppd)); %PD sin ganancia
K = 1/(sqrt(a)*mag) ; %Ganancia del PD
Gpd = Gpd1*K ; %controlador PD
Gpdzpk = zpk(Gpd);


Gpd = Gpdzpk;