model Capacitor
  extends OnePort;
  parameter Real C=1;
equation
  C * der(v) - i = 0;
end Capacitor;
