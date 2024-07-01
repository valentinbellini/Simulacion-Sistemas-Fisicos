package TP4Bellini
  model CoillBall
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
  end CoillBall;

  model MaglevSys
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
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = 1*0.79959396013) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoillBall coillBall(i(start = 0.79959396013)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource1(U = 0) annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-108, 42}, {-107.7, 42}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}}));
    connect(coillBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coillBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -24}}));
    connect(coillBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(stepSource1.y, add.u2) annotation(
      Line(points = {{-124, 30}, {-108, 30}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys;

  model MaglevSys_p3
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
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = 0.799539601031) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = 1) annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoillBall coillBall(i(start = 0.799539601031)) annotation(
      Placement(visible = true, transformation(origin = {19, 41}, extent = {{-31, 31}, {31, -31}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealInput realInput annotation(
      Placement(visible = true, transformation(origin = {-136, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-96, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Interfaces.RealOutput realOutput annotation(
      Placement(transformation(origin = {150, -44}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {94, 0}, extent = {{-10, -10}, {10, 10}})));
    DSFLib.ControlSystems.Sensors.Mechanical.Translational.DistanceSensor distanceSensor annotation(
      Placement(transformation(origin = {68, -8}, extent = {{10, -10}, {-10, 10}})));
    DSFLib.Mechanical.Translational.Components.Fixed fixed annotation(
      Placement(transformation(origin = {94, -14}, extent = {{-10, -10}, {10, 10}})));
  equation
    connect(add.u1, stepSource.y) annotation(
      Line(points = {{-108, 42}, {-107.7, 42}, {-107.7, 68}, {-124, 68}}));
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}}));
    connect(realInput, add.u2) annotation(
      Line(points = {{-136, 30}, {-108, 30}}));
    connect(coillBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coillBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -26}}));
    connect(realOutput, distanceSensor.y) annotation(
      Line(points = {{150, -44}, {150, -41}, {68, -41}, {68, -20}}));
    connect(coillBall.flange, mass.flange) annotation(
      Line(points = {{37, 14}, {37, -7}}));
    connect(distanceSensor.flange_a, fixed.flange) annotation(
      Line(points = {{78, -8}, {103, -8}, {103, -14}, {94, -14}}));
    connect(distanceSensor.flange_b, mass.flange) annotation(
      Line(points = {{58, -8}, {36, -8}}));
    annotation(
      Icon(graphics = {Text(origin = {-4, 0}, extent = {{-76, 52}, {76, -52}}, textString = "MaglevSys"), Rectangle(origin = {10, 2}, extent = {{-104, 40}, {104, -40}})}, coordinateSystem(extent = {{-100, -100}, {120, 100}})),
      Diagram);
  end MaglevSys_p3;

  model MaglevSys_p4
  DSFLib.Circuits.Components.Resistor resistor(R = 1) annotation(
      Placement(visible = true, transformation(origin = {-15, 71}, extent = {{-13, -13}, {13, 13}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.Mass mass(m = 0.02, s(start = 0.0)) annotation(
      Placement(visible = true, transformation(origin = {37, -7}, extent = {{-11, -11}, {11, 11}}, rotation = 0)));
    DSFLib.ControlSystems.Actuators.Circuits.ModulatedVoltageSource controlledVoltage annotation(
      Placement(visible = true, transformation(origin = {-59, 37}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.Circuits.Components.Ground ground annotation(
      Placement(visible = true, transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.Mechanical.Translational.Components.ConstForce constForce(F = -mass.m*9.8) annotation(
      Placement(visible = true, transformation(origin = {37, -39}, extent = {{-13, -13}, {13, 13}}, rotation = -90)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = 1*0.799539601031) annotation(
      Placement(visible = true, transformation(origin = {-136, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.Add add(k2 = 1) annotation(
      Placement(visible = true, transformation(origin = {-96, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    TP4Bellini.CoillBall coillBall(i(start = 0.799539601031)) annotation(
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
    connect(add.y, controlledVoltage.u) annotation(
      Line(points = {{-84, 36}, {-74, 36}, {-74, 37}}));
    connect(realInput, add.u2) annotation(
      Line(points = {{-136, 30}, {-108, 30}}));
    connect(coillBall.n, controlledVoltage.n) annotation(
      Line(points = {{20, 16}, {-60, 16}, {-60, 24}}));
    connect(controlledVoltage.p, resistor.p) annotation(
      Line(points = {{-58, 50}, {-60, 50}, {-60, 71}, {-28, 71}}));
    connect(resistor.n, coillBall.p) annotation(
      Line(points = {{-2, 71}, {18, 71}}));
    connect(ground.p, controlledVoltage.n) annotation(
      Line(points = {{-60, -2}, {-60, 24}}));
    connect(mass.flange, constForce.flange) annotation(
      Line(points = {{36.89, -7.11}, {37, -7.11}, {37, -26}}));
    connect(realOutput, distanceSensor.y) annotation(
      Line(points = {{137, -43}, {137, -43.5}, {71, -43.5}, {71, -18}}));
    connect(coillBall.flange, mass.flange) annotation(
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
  end MaglevSys_p4;

  model MaglevSysControlado
  DSFLib.ControlSystems.Blocks.Components.Add add1(k2 = 0.05) annotation(
      Placement(visible = true, transformation(origin = {-4, 34}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    DSFLib.ControlSystems.Blocks.Components.StepSource stepSource(U = 0) annotation(
      Placement(visible = true, transformation(origin = {-84, 86}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
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
      Line(points = {{-16, 33.8}, {-68, 33.8}, {-68, 73.8}, {-58, 73.8}}));
    connect(gain.y, transferFunction.u) annotation(
      Line(points = {{-2.2, 80}, {7.8, 80}}));
    connect(stepSource.y, add.u1) annotation(
      Line(points = {{-72.4, 86}, {-58.4, 86}}));
    connect(gain.u, add.y) annotation(
      Line(points = {{-25.7, 80.1}, {-33.7, 80.1}}));
    connect(MaglevSys2.realOutput, add1.u1) annotation(
      Line(points = {{78, 82.9273}, {92, 82.9273}, {92, 40.9273}, {8, 40.9273}}));
    connect(MaglevSys2.realOutput1, add1.u2) annotation(
      Line(points = {{78, 74.8909}, {82, 74.8909}, {82, 28.8909}, {8, 28.8909}}));
    connect(transferFunction.y, MaglevSys2.realInput) annotation(
      Line(points = {{31.8, 80}, {43.8, 80}, {43.8, 78}}));
    annotation(
      Icon(coordinateSystem(extent = {{-100, -100}, {120, 100}})));
  end MaglevSysControlado;
end TP4Bellini;
