model linearized_model "TP4Bellini_MaglevSys_p3"
  parameter Integer n = 3 "number of states";
  parameter Integer m = 1 "number of inputs";
  parameter Integer p = 1 "number of outputs";
  parameter Real x0[n] = {0.799539601031, 0, 0};
  parameter Real u0[m] = {0};

  parameter Real A[n, n] =
	[-181.2217973421418, 0, -88.83773344788891;
	0, 0, 1;
	24.51077668401418, 2177.505867278755, 0];

  parameter Real B[n, m] =
	[181.2217973012815;
	0;
	0];

  parameter Real C[p, n] =
	[0, 1, 0];

  parameter Real D[p, m] =
	[0];


  Real x[n](start=x0);
  input Real u[m](start=u0);
  output Real y[p];

  Real 'x_coillBall.i' = x[1];
  Real 'x_coillBall.y' = x[2];
  Real 'x_mass.v' = x[3];
  Real 'u_realInput' = u[1];
  Real 'y_realOutput' = y[1];
equation
  der(x) = A * x + B * u;
  y = C * x + D * u;
  
end linearized_model;
