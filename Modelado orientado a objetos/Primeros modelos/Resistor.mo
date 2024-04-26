model Resistor
  extends OnePort;
  parameter Real R=1;
equation
  R * i - v = 0;
end Resistor;
