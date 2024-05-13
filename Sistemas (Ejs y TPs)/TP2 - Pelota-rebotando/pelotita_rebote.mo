model pelotita_rebote
  import LookUpTable;
  
  // Variables de estado
  Real ym(start = 0), vm(start = 0);
  
  // Parámetros
  parameter Real m = 23e-3 "Masa de la pelotita (kg)";
  parameter Real g = 9.8 "Aceleración gravitatoria (m/s²)";
  parameter Real b = 1 "Coeficiente de amortiguamiento (N·s/m)";
  parameter Real deltay "Deformación de la pelotita (m)";
  
  // Fuerzas
  Real Fr, Fa, Fm, Fg;
  
equation
  // Ecuaciones de masa
  der(ym) = vm;
  der(vm) = Fm / m;
  // Fuerza de amortiguamiento
  Fa = b * vm;
  // Fuerza gravitatoria
  Fg = m * g;
  // Fuerza de deformación / Resorte
  Fr = LookUpTable(deltay);
  // Ley de Newton
  Fm = Fr - Fa - Fg;
  
end pelotita_rebote;
