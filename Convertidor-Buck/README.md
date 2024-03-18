En este trabajo trataremos distintos problemas vinculados a la Simulación de Sistemas Continuos. Más específicamente, analizaremos diferentes propiedades de los métodos de integración numérica
para ecuaciones diferenciales ordinarias y trabajaremos sobre los algoritmos de causalización de sistemas
de ecuaciones diferenciales algebraicas.

## 1. Convertidor Buck

El esquema de la figura representa un convertidor de continua en continua llamado `circuito buck` o `reductor`
El circuito cuenta con una llave que conmuta en alta frecuencia para producir una tensión de
salida sobre la resistencia de carga `R` cuyo valor medio es una fracción de la tensión de entrada `U`. La
relación entre las tensiones de entrada y salida la determina el ciclo de trabajo, es decir, la fracción de
tiempo que la llave permanece cerrada.

![circuito-buck](/Convertidor-Buck/images/circuito-buck.jpeg)

Trabajaremos modelando y simulando este circuito bajo diferentes hipótesis.

## 2. Análisis con un Modelo Simplificado

Si consideramos que la llave y el diodo son ideales y que el diodo no conduce cuando la llave está
cerrada y es un conductor ideal con la llave está abierta, podemos plantear las siguientes ecuaciones para
el modelo:

![Ecuaciones-modelo-ideal](/Convertidor-Buck/images/ecuaciones-ideal.jpeg)

donde uSD(t) e iSD(t) representan la tensión y corriente a la izquierda de la inductancia y s(t) es una
señal de entrada conocida que vale 1 si la llave está cerrada y 0 si la llave está abierta.

Consideraremos:

U = 12V, L = 10^(−4)Hy, C = 10^(−4)F y R = 10Ω.

Vamos a dividir el trabajo a realizar en 6 pasos:

- Obtener las ecuaciones de estado
- Buscar solución analítica de las ecuaciones de estado
- Utilizar el método de Forward Euler
- Utilizar el método de Heun
- Utilizar el método de Runge Kutta con Control de Paso
- Simulación del modelo Conmutado

## 3. Análisis con un modelo mas realista

Para considerar la posibilidad que tanto la llave como el diodo estén abiertos simultáneamente, es
necesario modelar más adecuadamente el diodo. Podríamos en principio considerar ideales la llave y el
diodo de manera que la corriente por los mismos sea nula al estar abiertos.

El problema con esta idea es que cuando ambos elementos estén abiertos, la corriente por la inductancia
será nula y tendremos una singularidad estructural, ya que la corriente dejará de ser una variable de estado.

Esto implicaría un cambio de estructura (y de orden) en el modelo, lo cuál complica tanto el análisis como
las simulaciones.

Una opción más simple es considerar que tanto la llave como el diodo tienen asociada una pequeña
resistencia de conducción `Ron` cuando están cerrados y una gran resistencia de corte `Roff` al estar abiertos.
Con esta idea, podemos modificar el sistema de la ecuación ideal como sigue:


![Ecuaciones-modelo-real](/Convertidor-Buck/images/ecuaciones-real.jpeg)

Ahora para este nuevo modelo realizaremos las siguientes tareas:

- Obtención de las ecuaciones de estado
- Simulación del modelo conmutado con Backward Euler
