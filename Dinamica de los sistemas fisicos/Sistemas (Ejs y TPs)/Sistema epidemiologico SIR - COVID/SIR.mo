model SIR
  Real S(start=1e6-1), I(start=1), R;
  parameter Real gamma=0.1177; // γ modela la inversa del tiempo medio que una persona infectada permanece como tal.
  parameter Real R0=1.65; // numero reproductivo basico
  parameter Real beta=gamma*R0;
  parameter Real N=1e6;
equation
  der(S) = -beta*S*I/N;
  der(I) = beta*S*I/N-gamma*I;
  der(R) = gamma*I;
end SIR;
