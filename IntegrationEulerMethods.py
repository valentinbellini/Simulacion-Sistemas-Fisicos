import numpy as np
import matplotlib.pyplot as plt

# En un sistema masa-resorte buscaremos la solucion aproximada a partir de los métodos Forward Euler y
# Backward Euler. Además, dejando los parámetros y la entrada constantes, cambiamos el paso de integración
# "h" para ver sus diferentes efectos en cada método.

def forward_euler_step(x_prev, v_prev, m, k, b, F, h):
    # Calcular la aceleración usando la segunda ley de Newton
    a = (F - k * x_prev - b * v_prev) / m
    
    # Actualizar la velocidad y la posición usando el método de Euler hacia adelante
    v_next = v_prev + a * h
    x_next = x_prev + v_prev * h
    
    return x_next, v_next

def backward_euler_step(x_prev, v_prev, m, k, b, F, h):
    # Función que define la ecuación a resolver
    def backward_euler_equation(x_next, x_prev, v_prev, m, k, b, F, h):
        return x_next - x_prev - h * v_next, v_next - v_prev - (F - k * x_next - b * v_next) / m * h
    
    # Aproximación inicial para la posición y la velocidad
    x_next = x_prev + h * v_prev
    v_next = v_prev + (F - k * x_next - b * v_prev) / m * h
    
    # Resolver la ecuación iterativamente usando el método de Newton-Raphson
    for _ in range(10):  # Realizar 10 iteraciones
        dx, dv = backward_euler_equation(x_next, x_prev, v_prev, m, k, b, F, h)
        x_next -= dx
        v_next -= dv
    
    return x_next, v_next

def sistema_masa_resorte(m, k, b, F_func, h, total_time, method = 0):
    num_steps = int(total_time / h)  # Número de pasos de tiempo
    t_values = np.zeros(num_steps)   # Array para almacenar los tiempos
    x_values = np.zeros(num_steps)   # Array para almacenar las posiciones
    v_values = np.zeros(num_steps)   # Array para almacenar las velocidades

    # Condiciones iniciales
    x_values[0] = 0.0  # Posición inicial
    v_values[0] = 0.0  # Velocidad inicial

    for i in range(1, num_steps):
        t = i * h  # Tiempo actual

        # Fuerza externa
        F = F_func(t)

        # Aplicar un paso de Euler hacia adelante según el método elegido
        if method == 0:
            x_values[i], v_values[i] = backward_euler_step(x_values[i - 1], v_values[i - 1], m, k, b, F, h)
        else:
            x_values[i], v_values[i] = forward_euler_step(x_values[i - 1], v_values[i - 1], m, k, b, F, h)

        # Almacenar el tiempo actual
        t_values[i] = t

    return t_values, x_values

# Función para la fuerza externa constante
def F_constante(t):
    return 1.0

# Parámetros del sistema
m = 1.0  # Masa
k = 1.0  # Constante del resorte
b = 1.0  # Coeficiente de fricción
total_time = 13.0  # Tiempo total de simulación
h_values = [0.01, 0.1, 0.25, 0.5, 0.75, 1.0]  # Valores de h que deseas probar

fig, (ax1, ax2) = plt.subplots(2)
fig.suptitle('Simulación de un sistema masa-resorte con fuerza externa constante')
# Simular y graficar el sistema para cada valor de h
for h in h_values:
    t_values, x_values = sistema_masa_resorte(m, k, b, F_constante, h, total_time, method = 0) # backward_euler_step
    t_values_2, x_values_2 = sistema_masa_resorte(m, k, b, F_constante, h, total_time, method = 1) # fordward_euler_step
    ax1.plot(t_values, x_values, label=f'h = {h}')
    ax2.plot(t_values_2, x_values_2, label=f'h = {h}')
    # plt.plot(t_values, x_values, label=f'h = {h}')

# Configuraciones adicionales del gráfico
ax1.set_title("Using Backward Euler Step")
ax1.legend()
ax1.grid(True)
ax2.set_title("Using Fordward Euler Step")
ax2.legend()
ax2.grid(True)


plt.show()
