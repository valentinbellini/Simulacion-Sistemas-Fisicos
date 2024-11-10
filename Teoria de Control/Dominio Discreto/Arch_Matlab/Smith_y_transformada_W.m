clear
clc
load('data.mat');

% Modelo del REACTOR BIODIESEL:
s = tf('s');
G =  ( 0.20827 / ((1+98.126*s)*(1+18.916*s)) ) * exp(-8*s);
T_muestreo = 8;
Gz = c2d(G, T_muestreo, 'zoh'); % Bloqueador Equivalente orden 0
Gz_sin_tm = Gz;
Gz_sin_tm.inputDelay = 0;

