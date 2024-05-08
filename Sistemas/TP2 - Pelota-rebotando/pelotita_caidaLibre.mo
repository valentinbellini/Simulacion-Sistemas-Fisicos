model PelotitaCaidaLibre

  // Parámetros
  parameter Real m = 0.026 "Masa de la pelotita (kg)";
  parameter Real g = 9.81 "Aceleración de la gravedad (m/s^2)";
  parameter Real b = 0.01 "Coeficiente de fricción (N*s/m)";

  // Variables de estado
  Real y(start = 10) "Posición vertical de la pelotita (m)";
  Real v(start = 0) "Velocidad vertical de la pelotita (m/s)";

equation
  // Ecuaciones de movimiento
  der(y) = v;
  m*der(v) = -m*g - b*v;
  
end PelotitaCaidaLibre;
