function [Gpi]=calculoPI(Gw,Gpd,xi,tr)
s = tf('s');
wn = 4/(xi*tr);
Zpi = wn/20;
tau_pi = 1/Zpi;
Gpi_NoGain = (1+tau_pi*s)/s;
[mag_gpi, phase_gpi] = bode(Gpi_NoGain, wn);
[mag, phase] = bode(Gw*Gpd, wn);
Kpi = 1/(mag_gpi*mag);
%Ppi = Zpi/5; % Polo del PI

Gpi = zpk(Kpi*Gpi_NoGain);

