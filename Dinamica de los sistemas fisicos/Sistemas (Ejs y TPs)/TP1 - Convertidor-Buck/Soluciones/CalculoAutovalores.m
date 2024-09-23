L = 1e-4;
C = 1e-4;
R = 10;
Roff = 1e5;

A = 1;
B = (1/(R*C))+(Roff/(2*L));
C = (Roff/(2*R*L*C))+1/(L*C);

p = [A B C];

r = roots(p);

% R1 = (-B+sqrt((B^2)-4*A*C))/(2*A);
% R2 = (-B-sqrt((B^2)-4*A*C))/(2*A);