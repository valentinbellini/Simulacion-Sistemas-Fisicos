# Simulación de sistemas físicos

En este repositorio se encuentra la simulación de varios sistemas utilizando herramientas como MatLab, Python y OpenModelica. Se utilizan distintos métodos de integración numérica monopaso y multipaso, así también como explícitos e implícitos con el objetivo de tener un panorama amplio sobre las diferentes soluciones y siempre buscando obtener una solución lo más aproximada a la analítica. Para las simulaciones en modelica se utiliza el solver `dassl`.

[Convertidor buck](/Sistemas/Convertidor-Buck/README.md) es un sistema de un convertidor muy utilizado en la electrónica completo, con un analisis detallado de distintos tipos de métodos de integración. En el mismo se partió de las ecuaciones de estado del sistema previamente calculadas.

[Pelota-rebotando](/Sistemas/Pelota-rebotando/README.md) es el modelo de un sistema simple de una pelotita arrojada desde cierta altura. Se realizaron 2 experimentos de diferentes alturas y se trackearon los datos para comparar el modelo con la experimentación y así poder ajustar los parámetros. El modelo es conmutado y se toman dos situaciones: la caida libre y el rebote contra el piso debido a la deformación del objeto.
