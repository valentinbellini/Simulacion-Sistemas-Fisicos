model Diode
  extends OnePort;
  parameter Real Ron=1e-5,Roff=1e5,Vknee=0.6;
equation
  i= if v>Vknee then (v-Vknee)/Ron+Vknee/Roff else v/Roff; // Vknee = Vgamma
end Diode;
