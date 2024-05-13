partial model OnePort
  Pin p, n;
  Real v, i;
equation
  v = p.v - n.v;
  p.i = i;
  n.i + p.i = 0;
end OnePort;
