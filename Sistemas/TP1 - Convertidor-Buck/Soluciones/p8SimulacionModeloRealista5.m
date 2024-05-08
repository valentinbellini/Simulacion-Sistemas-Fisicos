addpath('./Convertidor-Buck/funciones/');

x0 = [0 ; 0];   
t0 = 0;         
tf = 0.01;
h = [2e-5 1e-5 1e-6];

figure;
for i = 1:length(h)
    [t, x] = beuler(@buck2, x0, h(i), t0, tf);
    % Subplot para el paso h(i)
    subplot(length(h), 1, i);
    plot(t, x(1, :));
    hold on;
    plot(t, x(2, :));
    title(['Método de Backward Euler con h = ', num2str(h(i))]);
    legend('il', 'uc');
    grid on;
end