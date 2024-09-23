package TP4Bellini
  model CoilBall
    DSFLib.Mechanical.Translational.Interfaces.Flange flange annotation(
      Placement(visible = true, transformation(origin = {2, -42}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {106, -58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    extends DSFLib.Circuits.Interfaces.OnePort;
    DSFLib.Mechanical.Translational.Units.Position y;
    DSFLib.Mechanical.Translational.Units.Force f;
    parameter Real Lo = 5.5181e-3;
    parameter Real yo = 9e-3;
  equation
    y = flange.s;
    f = flange.f;
    f = -(Lo*(yo/((yo - y)^2))*(i^2))/2;
    v = Lo*(yo/((yo - y)^2))*der(y)*i + (Lo*(yo/(yo - y)))*der(i);
    annotation(
      Icon(graphics = {Rectangle(origin = {1, -56}, rotation = -90, fillColor = {124, 124, 123}, fillPattern = FillPattern.VerticalCylinder, extent = {{-20, 79}, {20, -79}}), Line(origin = {32.0333, -66.0293}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {92.1469, -66.1713}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {73.7492, -65.8872}, points = {{-12, 0}, {12, 0}, {22, 48}}), Line(origin = {1.74922, -65.8872}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {61.8628, -66.0293}, points = {{-60, 0}, {-59, 14}, {-52, 26}, {-36, 26}, {-31, 14}, {-30, 0}}, smooth = Smooth.Bezier), Line(origin = {-72.5831, -65.3041}, points = {{-16, 0}, {12, 0}, {12, 0}}), Line(origin = {-156.565, -67.6364}, points = {{70, 2}, {68, 2}, {60, 60}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})));
  end CoilBall;

  model MaglevSys
    
    parameter Real g = 9.8;
    parameter Real io = sqrt((2*mass.m*g*coilBall.yo)/coilBall.Lo);
     
  
    DSFLib.Circuits.Components.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-15, 71}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.Mass mass(m = 0.02, s(start = 0)) annotation(
      Placement(visible = true, transformation(origin = {37, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource controlledVoltage annotation(
      Placement(visible = true, transformation(origin = {-59, 37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.Circuits.Components.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -mass.m*9.8) annotation(
      Placement(visible = true, transformation(origin = {37, -37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = resistor.R*io) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add annotation(
      Placement(transformation(origin = {-90, 38}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource1(U = 0.01) annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoilBall coilBall(i(start = io)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-101, 44}, {-107.7, 44}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-79, 38}, {-79, 37}, {-74, 37}}));
    connect(coilBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coilBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -24}}));
    connect(coilBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(stepSource1.y, add.u2) annotation(
      Line(points = {{-124, 30}, {-111.5, 30}, {-111.5, 32}, {-101, 32}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys;

  model MaglevSys_p3
  
    parameter Real g = 9.8;
    parameter Real io = sqrt((2*mass.m*g*coilBall.yo)/coilBall.Lo);
    
    DSFLib.Circuits.Components.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-15, 71}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.Mass mass(m = 0.02) annotation(
      Placement(visible = true, transformation(origin = {37, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource controlledVoltage annotation(
      Placement(visible = true, transformation(origin = {-59, 37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.Circuits.Components.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -mass.m*9.8) annotation(
      Placement(visible = true, transformation(origin = {37, -39}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = resistor.R*io) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = 1) annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoilBall coilBall(i(start = 0.799539601031)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput realInput annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput annotation(
      Placement(transformation(origin = {150, -44}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.DistanceSensor distanceSensor annotation(
      Placement(transformation(origin = {62, -8}, extent = {{10, -10}, {-10, 10}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {86, -16}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-108, 42}, {-107.7, 42}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}}));
    connect(realInput, add.u2) annotation(
      Line(points = {{-136, 30}, {-108, 30}}));
    connect(coilBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coilBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -26}}));
    connect(realOutput, distanceSensor.y) annotation(
      Line(points = {{150, -44}, {150, -41}, {62, -41}, {62, -20}}));
    connect(coilBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(distanceSensor.flange_a, fixed.flange) annotation(
      Line(points = {{72, -8}, {87, -8}, {87, -16}, {86, -16}}));
    connect(distanceSensor.flange_b, mass.flange) annotation(
      Line(points = {{52, -8}, {36, -8}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys_p3;

  model MaglevSys_p4
  
    parameter Real g = 9.8;
    parameter Real io = sqrt((2*mass.m*g*coilBall.yo)/coilBall.Lo);
    
    DSFLib.Circuits.Components.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-15, 71}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.Mass mass(m = 0.02, s(start = 0.00)) annotation(
      Placement(visible = true, transformation(origin = {37, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource controlledVoltage annotation(
      Placement(transformation(origin = {-61, 37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.Circuits.Components.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -mass.m*9.8) annotation(
      Placement(visible = true, transformation(origin = {37, -39}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = resistor.R*io) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = 1) annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoilBall coilBall(i(start = io)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput realInput annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput annotation(
      Placement(transformation(origin = {137, -43}, extent = {{-9, -9}, {9, 9}}), iconTransformation(origin = {120, 26}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.DistanceSensor distanceSensor annotation(
      Placement(transformation(origin = {71, -7}, extent = {{9, -9}, {-9, 9}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {90, -16}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.SpeedSensor speedSensor annotation(
      Placement(visible = true, transformation(origin = {-1, -7}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput1 annotation(
      Placement(transformation(origin = {137, -73}, extent = {{-9, -9}, {9, 9}}), iconTransformation(origin = {120, -26}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed1 annotation(
      Placement(transformation(origin = {-34, -40}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-108, 42}, {-107.7, 42}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}, {-69, 37}}));
    connect(realInput, add.u2) annotation(
      Line(points = {{-136, 30}, {-108, 30}}));
    connect(coilBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}, {-61, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-61, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coilBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 11}, {-61, 11}, {-61, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -26}}));
    connect(realOutput, distanceSensor.y) annotation(
      Line(points = {{137, -43}, {137, -43.5}, {71, -43.5}, {71, -18}}));
    connect(coilBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(speedSensor.y, realOutput1) annotation(
      Line(points = {{-1, -18}, {-1, -73.5}, {137, -73.5}, {137, -73}}));
    connect(fixed1.flange, speedSensor.flange_a) annotation(
      Line(points = {{-34, -40}, {-34, -8}, {-10, -8}}));
    connect(speedSensor.flange_b, mass.flange) annotation(
      Line(points = {{8, -8}, {36, -8}}));
    connect(mass.flange, distanceSensor.flange_b) annotation(
      Line(points = {{36, -8}, {54, -8}, {54, -7}, {62, -7}}));
    connect(distanceSensor.flange_a, fixed.flange) annotation(
      Line(points = {{80, -7}, {95, -7}, {95, -16}, {90, -16}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys_p4;

  model MaglevSysControlado
  DSFLib.ControlSystems.Blocks.Components.Add add1(k2 = 0.05) annotation(
      Placement(transformation(origin = {0, 30}, extent = {{14, -14}, {-14, 14}})));
    DSFLib.ControlSystems.Blocks.Components.StepSource yref(U = 0.0) annotation(
      Placement(transformation(origin = {-86, 84}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Blocks.Components.Gain gain(K = 3843) annotation(
      Placement(visible = true, transformation(origin = {-14, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = -1) annotation(
      Placement(visible = true, transformation(origin = {-46, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.TransferFunction transferFunction(den = {1, 0}, num = {(1/20), 1}) annotation(
      Placement(visible = true, transformation(origin = {20, 80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.MaglevSys_p4 MaglevSys2 annotation(
      Placement(visible = true, transformation(origin = {59.4545, 78.9091}, extent = {{-15.4545, -15.4545}, {18.5455, 15.4545}}, rotation = 0)));
  equation
    connect(add1.y, add.u2) annotation(
      Line(points = {{-15, 30}, {-68, 30}, {-68, 73.8}, {-58, 73.8}}));
    connect(gain.y, transferFunction.u) annotation(
      Line(points = {{-2.2, 80}, {7.8, 80}}));
    connect(yref.y, add.u1) annotation(
      Line(points = {{-75, 84}, {-66.7, 84}, {-66.7, 86}, {-58.4, 86}}));
    connect(gain.u, add.y) annotation(
      Line(points = {{-25.7, 80.1}, {-33.7, 80.1}}));
    connect(MaglevSys2.realOutput, add1.u1) annotation(
      Line(points = {{78, 82.9273}, {92, 82.9273}, {92, 38}, {15, 38}}));
    connect(MaglevSys2.realOutput1, add1.u2) annotation(
      Line(points = {{78, 74.8909}, {82, 74.8909}, {82, 22}, {15, 22}}));
    connect(transferFunction.y, MaglevSys2.realInput) annotation(
      Line(points = {{31.8, 80}, {43.8, 80}, {43.8, 78}}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {120, 100}})));
  end MaglevSysControlado;

  model ControlNoLineal
  
    parameter Real y0 = 9e-3;
    parameter Real L0 = 5.5181e-3;
    parameter Real m = 0.02;
    parameter Real g = 9.8;
    parameter Real c = 30;
    parameter Real i0 = sqrt((2*m*g*y0)/L0);
    
    Real x1(start = 0.001); // Posicion
    Real x2(start = 0.0); // Velocidad
    Real u;  // Entrada de corriente (La despeja Modelica a traves de las DAEs)
    
  equation
    // Ecuacion 13 del TP:
    der(x1) = x2;
    der(x2) = ((L0*y0*((u + i0)^2))/(2*m*((y0 - x1)^2))) - g;
    // Ecuacion 17 (usar c = 30)
    ((2*x1*(y0 - x1) + x1^2)/((y0 - x1)^2)) + ((L0*y0*((u + i0)^2))/(2*m*((y0 - x1)^2))) - g = -c*x2;
  end ControlNoLineal;

  model linearized_model "TP4Bellini_MaglevSys_p3"
  parameter Integer n = 3 "number of states";
    parameter Integer m = 1 "number of inputs";
    parameter Integer p = 1 "number of outputs";
    parameter Real x0[n] = {0.799539601031, 0, 0};
    parameter Real u0[m] = {0};
    parameter Real A[n, n] = [-181.2217973421418, 0, -88.83773344788891; 0, 0, 1; 24.51077668401418, 2177.505867278755, 0];
    parameter Real B[n, m] = [181.2217973012815; 0; 0];
    parameter Real C[p, n] = [0, 1, 0];
    parameter Real D[p, m] = [0];
    Real x[n](start = x0);
    input Real u[m](start = u0);  
    output Real y[p];
    Real 'x_coillBall.i' = x[1];
    Real 'x_coillBall.y' = x[2];
    Real 'x_mass.v' = x[3];
    Real 'u_realInput' = u[1];
    Real 'y_realOutput' = y[1];
  equation
    der(x) = A*x + B*u;
    y = C*x + D*u;
  end linearized_model;

  model ControlNoLineal2
  
    parameter Real y0 = 9e-3;
    parameter Real L0 = 5.5181e-3;
    parameter Real m = 0.02;
    parameter Real g = 9.8;
    parameter Real c = 30;
    parameter Real yref = 0.00;
    parameter Real i0 = sqrt((2*m*g*y0)/L0);
    
    Real x1(start = 0.001); // Posicion
    Real x2;  // Velocidad
    Real u;   // Entrada de corriente
    
  equation
    der(x1) = x2;
    der(x2) = ((L0*y0*((u + i0)^2))/(2*m*((y0 - x1)^2))) - g;
    // Ecuacion 18
    (2*(x1 - yref)*(y0 - x1) + (x1 - yref)^2)/(y0 - x1)^2 + ((L0*y0*((u + i0)^2))/(2*m*((y0 - x1)^2))) - g = -c*x2;
  end ControlNoLineal2;

  model MaglevSys_LY
  parameter Real g = 9.8;
    parameter Real io = sqrt((2*mass.m*g*coilBall.yo)/coilBall.Lo);
    DSFLib.Circuits.Components.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-15, 71}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.Mass mass(m = 0.02, s(start = 0.002)) annotation(
      Placement(visible = true, transformation(origin = {37, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    DSFLib.ControlSystems.Actuators.Circuits.ModulatedCurrentSource controlledCurrent annotation(
      Placement(visible = true, transformation(origin = {-59, 37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.Circuits.Components.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -mass.m*9.8) annotation(
      Placement(visible = true, transformation(origin = {37, -39}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = io) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = 1) annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoilBall coilBall(i(start = io)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput realInput annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput annotation(
      Placement(transformation(origin = {137, -43}, extent = {{-9, -9}, {9, 9}}), iconTransformation(origin = {120, 26}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.DistanceSensor distanceSensor annotation(
      Placement(transformation(origin = {71, -7}, extent = {{9, -9}, {-9, 9}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {92, -10}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.SpeedSensor speedSensor annotation(
      Placement(visible = true, transformation(origin = {-1, -7}, extent = {{-9, -9}, {9, 9}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput1 annotation(
      Placement(transformation(origin = {137, -73}, extent = {{-9, -9}, {9, 9}}), iconTransformation(origin = {120, -26}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed1 annotation(
      Placement(transformation(origin = {-34, -40}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-108, 42}, {-107.7, 42}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledCurrent.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}}));
    connect(realInput, add.u2) annotation(
      Line(points = {{-136, 30}, {-108, 30}}));
    connect(coilBall.n, controlledCurrent.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledCurrent.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coilBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledCurrent.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -26}}));
    connect(realOutput, distanceSensor.y) annotation(
      Line(points = {{137, -43}, {137, -43.5}, {71, -43.5}, {71, -18}}));
    connect(coilBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(speedSensor.y, realOutput1) annotation(
      Line(points = {{-1, -18}, {-1, -73.5}, {137, -73.5}, {137, -73}}));
    connect(fixed1.flange, speedSensor.flange_a) annotation(
      Line(points = {{-34, -40}, {-34, -8}, {-10, -8}}));
    connect(speedSensor.flange_b, mass.flange) annotation(
      Line(points = {{8, -8}, {36, -8}}));
    connect(mass.flange, distanceSensor.flange_b) annotation(
      Line(points = {{36, -8}, {54, -8}, {54, -7}, {62, -7}}));
    connect(distanceSensor.flange_a, fixed.flange) annotation(
      Line(points = {{80, -7}, {103, -7}, {103, -10}, {92, -10}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys_LY;

  block LyCont
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput u annotation(
      Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput x1 annotation(
      Placement(transformation(origin = {-70, 32}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-70, 30}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput x2 annotation(
      Placement(transformation(origin = {-70, -42}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-70, -34}, extent = {{-10, -10}, {10, 10}})));
    parameter Real y0 = 9e-3;
    parameter Real L0 = 5.5181e-3;
    parameter Real m = 0.02;
    parameter Real g = 9.8;
    parameter Real c = 10; // Constante de amortiguamiento ?
    parameter Real i0 = sqrt((2*m*g*y0)/L0);
  equation
    u = sqrt((2*m*(y0 - x1)^2/(L0*y0))*(-c*x2 + g - 2*x1*(y0 - x1) - (x1^2)/((y0 - x1)^2))) - i0;
    annotation(
      Diagram,
      Icon(graphics = {Rectangle(origin = {-10, 4}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-70, 60}, {70, -60}}), Text(origin = {-12, 2}, extent = {{-32, 36}, {32, -36}}, textString = "LyCont")}));
  end LyCont;

  model ControlLY
    MaglevSys_LY maglevSys_LY annotation(
      Placement(transformation(origin = {-2, 56}, extent = {{-11, -10}, {11, 10}})));
    LyCont lyCont annotation(
      Placement(transformation(origin = {38, 56}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(maglevSys_LY.realOutput, lyCont.x1) annotation(
      Line(points = {{10, 59}, {31, 59}}, color = {0, 0, 127}));
    connect(maglevSys_LY.realOutput1, lyCont.x2) annotation(
      Line(points = {{10, 53}, {31, 53}}, color = {0, 0, 127}));
    connect(lyCont.u, maglevSys_LY.realInput) annotation(
      Line(points = {{45, 56}, {48, 56}, {48, 40}, {-20, 40}, {-20, 56}, {-12, 56}}, color = {0, 0, 127}));
  end ControlLY;
end TP4Bellini;
