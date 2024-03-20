import numpy as np
import matplotlib.pyplot as plt

def buck(x, t, L, C, R, U): 
    iL = x[0]
    uC = x[1]
    der_x1 = (1/L) * U - (1/L) * uC
    der_x2 = (1/C) * iL - (1/(R*C)) * uC
    dx = np.array([der_x1, der_x2])
    return dx

def rk4_integration(f, x0, t, L, C, R, u):
    n = len(x0)
    N = len(t)
    x = np.zeros((n, N))
    x[:, 0] = x0
    for k in range(1, N):
        dt = t[k] - t[k-1]
        k1 = dt * f(x[:, k-1], t[k-1], L, C, R, u)
        k2 = dt * f(x[:, k-1] + 0.5 * k1, t[k-1] + 0.5 * dt, L, C, R, u)
        k3 = dt * f(x[:, k-1] + 0.5 * k2, t[k-1] + 0.5 * dt, L, C, R, u)
        k4 = dt * f(x[:, k-1] + k3, t[k-1] + dt, L, C, R, u)
        x[:, k] = x[:, k-1] + (1/6) * (k1 + 2*k2 + 2*k3 + k4)
    return x

L = 1e-4
C = 1e-4
R = 10
U = 12
t = np.arange(0, 0.01, 1e-5) # Vector de tiempo
x0 = np.array([0, 0])  # Condiciones iniciales nulas

xa = rk4_integration(buck, x0, t, L, C, R, U)


# PLOTEO
plt.figure()
plt.plot(t, xa[0, :])
plt.plot(t, xa[1, :])
plt.legend(['il', 'uc'])
plt.title('Solucion numérica - Método RK4')
plt.grid(True)
plt.show()