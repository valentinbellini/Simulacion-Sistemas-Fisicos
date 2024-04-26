model Inductor
  extends OnePort;
  parameter Real L=1;
equation
  L * der(i) - v = 0;
end Inductor;

