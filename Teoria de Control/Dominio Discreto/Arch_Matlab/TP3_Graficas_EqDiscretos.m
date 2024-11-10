% ----------------------- Graficar polos y ceros ----------------------- %
figure;
subplot(1,2,1);
pzmap(Jz_TRR_T1, Jz_FRR_T1, Jz_BRR_T1, Jz_MPZ_T1, Jz_B0_T1);
title('Polos y Ceros con T_1 = 2s');
legend('Trapezoidal', 'Rect. Adelanto', 'Rect. Atraso', 'Mapeo PZ', 'B0 eq');
grid on;

subplot(1,2,2);
pzmap(Jz_TRR_T2, Jz_FRR_T2, Jz_BRR_T2, Jz_MPZ_T2, Jz_B0_T2);
title('Polos y Ceros con T_2 = 20s');
legend('Trapezoidal', 'Rect. Adelanto', 'Rect. Atraso', 'Mapeo PZ', 'B0 eq');
grid on;
% ---------------------------------------------------------------------- %



% Se selecciona para el analisis la integracion por regla trapezoidal
% ----------------------- Graficar polos y ceros ----------------------- %
figure;
subplot(1,2,1);
pzmap(Jz_TRR_T1);
title('Polos y Ceros con T_1 = 2.5s');
legend('Trapezoidal');
grid on;

subplot(1,2,2);
pzmap(Jz_TRR_T2);
title('Polos y Ceros con T_2 = 25s');
legend('Trapezoidal');
grid on;

% ---------------- Graficar la respuesta en frecuencia ---------------- %
figure;
subplot(2,1,1);
bode(J_zpk, Jz_TRR_T1);
title('Diagrama de Bode con T_1 = 2.5s');
legend('J(s)','J(z)_TRR');
grid on;

subplot(2,1,2);
bode(J_zpk, Jz_TRR_T2);
title('Diagrama de Bode con T_2 = 25s');
legend('J(s)','J(z)_TRR');
grid on;

