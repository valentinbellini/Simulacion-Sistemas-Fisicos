En este trabajo modelaremos y simularemos un sistema real consistente en una pelota que
rebota contra el piso. En el desarrollo del mismo, partiendo del sistema real plantearemos las hipótesis
simplificatorias que nos permitan arribar al esquema de un sistema físico idealizado. En base a estas
simplificaciones, plantearemos un modelo matemático y diseñaremos experimentos que nos permitan
obtener valores para los parámetros de dicho modelo. Luego, verificaremos mediante simulación que los
parámetros sean correctos (ajustando eventualmente sus valores) y que las hipótesis simplificatorias sean
adecuadas (replanteando eventualmente parte de las mismas).

##  Formulación del Sistema Físico Idealizado

El objetivo del modelo será describir el movimiento vertical de la pelota desde que la misma es soltada desde una altura inicial `y0` hasta que transcurre cierto tiempo en el cual la pelota puede rebotar varias veces contra el piso.
Algunas hipótesis necesarias para describir el sistema físico idealizado son:
1. Se considerará en principio solo el movimiento vertical del centro de masa de la pelota, teniendo en
cuenta la aceleración gravitatoria.
2. El piso se considerará absolutamente indeformable.
3. Se asumirá que parte de la fuerza de interacción entre el piso y la pelota depende de la deformación
de la misma y posee una ley no lineal.

Para cada una de las situaciones (pelota en el aire o en contacto con el piso) se deberá formular un
modelo matemático en forma de sistema de ecuaciones diferenciales algebraicas. Luego, se deberá formular
un modelo matemático unificado que incluya la condición de conmutación entre ambas situaciones.

## Experimentación para Parametrizar

Con el objetivo de obtener los parámetros del modelo, se deberá:

1. Pesar la pelotita y medir su diámetro.
2. Obtener la curva de fuerza vs. deformación. Para esto hay un instrumento adecuado en el Laboratorio de Automatización y Control que permite obtener distintos puntos de la curva modificandola deformación y midiendo la fuerza.
3. Soltar la pelotita desde diferentes alturas filmando las trayectorias correspondientes. La pelotita
debe estar junto a un patrón de referencia que permita posteriormente determinar la altura respecto
del piso en cada fotograma.

## Procesamiento de datos

Para poder utilizar los datos de las trayectorias filmadas en las etapas posteriores de ajuste de parámetros y validación, se deberán extraer y procesar los mismo. Para esto utilizamos el software de código abierto [`Tracker`](https://physlets.org/tracker/) y los guardamos en [exper1.txt](/Sistemas/Pelota-rebotando/exper1.txt).

## Construcción del modelo, simulación y ajuste de parámetros

Utilizando Modelica se contruye un modelo matemático con los parámetros medidos y utilizando valores arbitrarios con los parámetros que no se pudieron medir (como la fricción). Utilizaremos una función para la relación no lineal de la deformación medida, la misma está definida en [LookUpTable](/Sistemas/Pelota-rebotando/LookUpTable.mo).

Luego, se elige una de las trayectorias filmadas y trackeadas y se compara con la simulación del modelo para ajustar los parámetros del mismo. Una vez calibrado, se compara los resultados con la segunda trayectoria para corroborar que los resultados son los mismos. En este punto se ha realizado y verificado correctamente el modelado de un sistema real. Se puede ver los resultados de la simulación en [Bball](/Sistemas/Pelota-rebotando/BBall.mo).

## Extensión del modelo a dos dimensiones.
Se extiende el modelo a dos dimensiones suponiendo la presencia de un frontón. Si se asume que ambos movimientos están desacoplados, se puede lograr esto creando un nuevo modelo que contenga dos instancias del modelo del movimiento vertical, una de ellas con el parámetro que representa la gravedad `g` cambiado a un valor nulo. Notar que, para simular el movimiento horizontal, se debe dar una condición inicial positiva a la posición y una negativa a la velocidad (de modo que la pelota comience a la derecha del frontón y avance hacia él). Se puede ver los resultados de la simulación en el modelo [Bball_2D.mo](/Sistemas/Pelota-rebotando/BBal_2D.mo).

