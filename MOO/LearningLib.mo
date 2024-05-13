package LearningLib
  package Circuits
    package Interfaces
      connector Pin
        LearningLib.Circuits.Units.Voltage v;
        flow LearningLib.Circuits.Units.Current i;
        annotation(
          Icon(graphics = {Rectangle(fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
      end Pin;

      partial model OnePort
        LearningLib.Circuits.Interfaces.Pin p annotation(
          Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        LearningLib.Circuits.Interfaces.Pin n annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        LearningLib.Circuits.Units.Voltage v;
        LearningLib.Circuits.Units.Current i;
      equation
        v = p.v - n.v;
        p.i = i;
        n.i + p.i = 0;
      end OnePort;
    end Interfaces;

    package Components
      model Ground
        LearningLib.Circuits.Interfaces.Pin p annotation(
          Placement(visible = true, transformation(origin = {-102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 80}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
      equation
        p.v = 0;
        annotation(
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(origin = {0, -30}, points = {{-60, 50}, {60, 50}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{-40, 30}, {40, 30}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{-20, 10}, {20, 10}}, color = {0, 0, 255}), Line(origin = {0, -30}, points = {{0, 96}, {0, 50}}, color = {0, 0, 255}), Text(origin = {0, -30}, textColor = {0, 0, 255}, extent = {{-150, -10}, {150, -50}}, textString = " %name")}));
      end Ground;

      model Resistor
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real R(unit = "Ω") = 1;
      equation
        v - R*i = 0;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{70, 0}, {90, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "R=%R"), Line(points = {{-90, 0}, {-70, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Rectangle(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-70, 24}, {70, -24}}), Line(visible = false, points = {{0, -100}, {0, -30}}, color = {127, 0, 0}, pattern = LinePattern.Dot)}));
      end Resistor;

      model Capacitor
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real C(unit = "F") = 1;
      equation
        C*der(v) - i = 0;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(origin = {4, 0}, points = {{6, 40}, {6, -40}}, color = {0, 0, 255}), Line(origin = {-4, 0}, points = {{-6, 40}, {-6, -40}}, color = {0, 0, 255}), Text(extent = {{-150, -40}, {150, -80}}, textString = "C=%C"), Line(points = {{10, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-10, 0}}, color = {0, 0, 255})}));
      end Capacitor;

      model Inductor
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real L(unit = "H") = 1;
      equation
        L*der(i) - v = 0;
        annotation(
          Icon(graphics = {Text(extent = {{-150, -40}, {150, -80}}, textString = "L=%L"), Line(points = {{-30, 0}, {-29, 6}, {-22, 14}, {-8, 14}, {-1, 6}, {0, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{30, 0}, {31, 6}, {38, 14}, {52, 14}, {59, 6}, {60, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-60, 0}, {-59, 6}, {-52, 14}, {-38, 14}, {-31, 6}, {-30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{-90, 0}, {-60, 0}}, color = {0, 0, 255}), Line(points = {{0, 0}, {1, 6}, {8, 14}, {22, 14}, {29, 6}, {30, 0}}, color = {0, 0, 255}, smooth = Smooth.Bezier), Line(points = {{60, 0}, {90, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}));
      end Inductor;

      model Diode
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5, Vknee = 0.6;
      equation
        i = if v > Vknee then (v - Vknee)/Ron + Vknee/Roff else v/Roff;
        annotation(
          Icon(graphics = {Line(visible = false, points = {{0, -100}, {0, -20}}, color = {127, 0, 0}, pattern = LinePattern.Dot), Line(points = {{-90, 0}, {40, 0}}, color = {0, 0, 255}), Polygon(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{30, 0}, {-30, 40}, {-30, -40}, {30, 0}}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{30, 40}, {30, -40}}, color = {0, 0, 255})}));
      end Diode;

      model Switch
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real Ron = 1e-5, Roff = 1e5;
        discrete Real s;
      equation
        v = if s > 0.5 then i*Ron else i*Roff;
        annotation(
          Icon(graphics = {Line(points = {{-37, 2}, {40, 40}}, color = {0, 0, 255}), Ellipse(lineColor = {0, 0, 255}, extent = {{-44, 4}, {-36, -4}}), Text(textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{-90, 0}, {-44, 0}}, color = {0, 0, 255}), Line(points = {{40, 0}, {90, 0}}, color = {0, 0, 255})}));
      end Switch;

      model ConstCurr
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real I(unit = "A") = 1;
      equation
        i = -I;
        annotation(
          Icon(graphics = {Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 60}, {150, 100}}, textString = "%name"), Line(points = {{0, -50}, {0, 50}}, color = {0, 0, 255}), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Text(extent = {{-150, -100}, {150, -60}}, textString = "I=%I"), Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Polygon(origin = {44, 0}, rotation = 180, lineColor = {0, 0, 255}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{90, 0}, {60, 10}, {60, -10}, {90, 0}}), Line(origin = {14, 0}, points = {{-30, 0}, {30, 0}, {30, 0}}, color = {0, 0, 255})}));
      end ConstCurr;

      model ConstVolt
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter Real V(unit = "V") = 1;
      equation
        v = V;
        annotation(
          Icon(graphics = {Ellipse(lineColor = {0, 0, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-50, 50}, {50, -50}}), Line(points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Text(extent = {{-150, -110}, {150, -70}}, textString = "V=%V"), Line(points = {{60, 20}, {80, 20}}, color = {0, 0, 255}), Text(textColor = {0, 0, 255}, extent = {{-150, 70}, {150, 110}}, textString = "%name"), Line(points = {{-90, 0}, {-50, 0}}, color = {0, 0, 255}), Line(points = {{-50, 0}, {50, 0}}, color = {0, 0, 255}), Line(points = {{50, 0}, {90, 0}}, color = {0, 0, 255}), Line(points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
      end ConstVolt;

      model VSenoidal
        extends LearningLib.Circuits.Interfaces.OnePort;
        parameter LearningLib.Circuits.Units.Voltage V = 1;
        // Amplitud
        parameter Real f(unit = "Hz") = 1.0;
        // Frecuencia
      equation
        v = V*sin(2.0*3, 14*f*time);
      end VSenoidal;
    end Components;

    package Units
      type Voltage = Real(unit = "V");
      type Current = Real(unit = "A");
    end Units;

    package Examples
      model RLC
        LearningLib.Circuits.Components.Resistor res(R = 1) annotation(
          Placement(visible = true, transformation(origin = {8, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        LearningLib.Circuits.Components.Ground ground annotation(
          Placement(visible = true, transformation(origin = {-8, -6}, extent = {{-8, -8}, {8, 8}}, rotation = 0)));
        LearningLib.Circuits.Components.Capacitor cap(C = 100e-6, v(start = 1)) annotation(
          Placement(visible = true, transformation(origin = {32, 22}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        LearningLib.Circuits.Components.Inductor ind(L = 1e-3) annotation(
          Placement(visible = true, transformation(origin = {-28, 50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(ind.n, res.p) annotation(
          Line(points = {{-18, 50}, {-2, 50}}));
        connect(ind.p, ground.p) annotation(
          Line(points = {{-38, 50}, {-47.5, 50}, {-47.5, 0}, {-8, 0}}));
        connect(cap.n, ground.p) annotation(
          Line(points = {{32, 12}, {31.5, 12}, {31.5, 0}, {-8, 0}}));
        connect(res.n, cap.p) annotation(
          Line(points = {{18, 50}, {32, 50}, {32, 32}}));
        annotation(
          experiment(StartTime = 0, StopTime = 0.02, Tolerance = 1e-6, Interval = 4e-05));
      end RLC;

      package SolarPanels
        package Components
          model SolarCell
            LearningLib.Circuits.Components.Diode diodo annotation(
              Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
            LearningLib.Circuits.Components.Resistor rs(R = 0.02) annotation(
              Placement(visible = true, transformation(origin = {52, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            LearningLib.Circuits.Components.Resistor rsh(R = 250) annotation(
              Placement(visible = true, transformation(origin = {22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
            LearningLib.Circuits.Interfaces.Pin p annotation(
              Placement(visible = true, transformation(origin = {20, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
            LearningLib.Circuits.Interfaces.Pin n annotation(
              Placement(visible = true, transformation(origin = {22, -34}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
            LearningLib.Circuits.Components.ConstCurr Iph annotation(
              Placement(visible = true, transformation(origin = {-22, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          equation
            connect(diodo.p, rs.p) annotation(
              Line(points = {{0, 10}, {0, 20}, {42, 20}}));
            connect(rsh.p, rs.p) annotation(
              Line(points = {{22, 10}, {22, 10}, {22, 20}, {42, 20}, {42, 20}}));
            connect(rs.n, p) annotation(
              Line(points = {{62, 20}, {62, 40}, {20, 40}}));
            connect(rsh.n, diodo.n) annotation(
              Line(points = {{22, -10}, {22, -20}, {0, -20}, {0, -10}}));
            connect(Iph.p, rs.p) annotation(
              Line(points = {{-22, 10}, {-22, 20}, {42, 20}}));
            connect(Iph.n, diodo.n) annotation(
              Line(points = {{-22, -10}, {-22, -20}, {0, -20}, {0, -10}}));
            connect(rsh.n, n) annotation(
              Line(points = {{22, -10}, {22, -34}}));
          protected
            annotation(
              Diagram,
              Icon(graphics = {Rectangle(lineColor = {147, 147, 147}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-88, 88}, {88, -88}}), Polygon(origin = {0, 1}, lineColor = {62, 62, 62}, fillPattern = FillPattern.Vertical, points = {{-60, 79}, {-80, 59}, {-80, -61}, {-60, -81}, {60, -81}, {80, -61}, {80, 59}, {60, 79}, {-54, 79}, {-60, 79}, {-60, 79}}), Line(origin = {-29.51, 23.68}, points = {{0, 56}, {0, -40}, {0, -102}}, color = {147, 147, 147}, thickness = 0.5), Line(origin = {29.55, 23.88}, points = {{0, 56}, {0, -40}, {0, -104}}, color = {147, 147, 147}, thickness = 0.5), Line(origin = {46.3446, 105}, points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Line(origin = {46.3446, 105}, points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
          end SolarCell;

          model SolarPanel
            parameter Integer N = 3, M = 4;
            // Matriz de celdas
            LearningLib.Circuits.Examples.SolarPanels.Components.SolarCell[N, M] cell;
            LearningLib.Circuits.Interfaces.Pin p annotation(
              Placement(visible = true, transformation(origin = {100, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
            LearningLib.Circuits.Interfaces.Pin n annotation(
              Placement(visible = true, transformation(origin = {98, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-104, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          equation
            for i in 1:N loop
              for j in 1:M - 1 loop
                connect(cell[i, j].p, cell[i, j + 1].p);
                connect(cell[i, j].n, cell[i, j + 1].n);
              end for;
            end for;
            for i in 1:N - 1 loop
              connect(cell[i, 1].n, cell[i + 1, 1].p);
            end for;
            connect(cell[1, 1].p, p);
            connect(cell[N, 1].n, n);
            annotation(
              Icon(graphics = {Bitmap(origin = {-1, -3}, rotation = 90, extent = {{-99, 95}, {99, -95}}, imageSource = "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"), Line(origin = {190.086, 0.362069}, points = {{-80, 20}, {-60, 20}}, color = {0, 0, 255}), Line(origin = {190.086, 0.362069}, points = {{-70, 30}, {-70, 10}}, color = {0, 0, 255})}));
          end SolarPanel;
        end Components;

        model TwoCells
          LearningLib.Circuits.Components.Ground ground annotation(
            Placement(visible = true, transformation(origin = {-2, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          LearningLib.Circuits.Components.Resistor rl(R = 1) annotation(
            Placement(visible = true, transformation(origin = {-2, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          LearningLib.Circuits.Components.Capacitor capacitor(C = 1e-3) annotation(
            Placement(visible = true, transformation(origin = {24, -4}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
          LearningLib.Circuits.Examples.SolarPanels.Components.SolarCell solarCell_1 annotation(
            Placement(visible = true, transformation(origin = {-30, 10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
          DSFLib.Circuits.Examples.SolarPanels.Components.SolarCell solarCell_2 annotation(
            Placement(visible = true, transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        equation
          connect(rl.n, ground.p) annotation(
            Line(points = {{-2, -14}, {-2, -40}}));
          connect(ground.p, capacitor.n) annotation(
            Line(points = {{-2, -40}, {24, -40}, {24, -14}}));
          connect(solarCell_1.n, solarCell_2.p) annotation(
            Line(points = {{-30, 0}, {-30, -10}}));
          connect(solarCell_2.n, ground.p) annotation(
            Line(points = {{-30, -30}, {-30, -40}, {-2, -40}}));
          connect(solarCell_1.p, capacitor.p) annotation(
            Line(points = {{-30, 20}, {-30, 30}, {24, 30}, {24, 6}}));
          connect(rl.p, solarCell_1.p) annotation(
            Line(points = {{-2, 6}, {-2, 30}, {-30, 30}, {-30, 20}}));
          annotation(
            experiment(StartTime = 0, StopTime = 0.02, Tolerance = 1e-6, Interval = 4e-05));
        end TwoCells;
      end SolarPanels;

      model ConvertidorBuck
        parameter Real period = 1e-4;
        parameter Real dutyCycle = 0.5;
        LearningLib.Circuits.Components.Capacitor capacitor(C = 10e-4);
        LearningLib.Circuits.Components.Resistor rl(R = 10);
        LearningLib.Circuits.Components.Diode diodo;
        LearningLib.Circuits.Components.Inductor inductor(L = 10e-4);
        LearningLib.Circuits.Components.Ground ground;
        LearningLib.Circuits.Components.ConstVolt u(V = 12);
        LearningLib.Circuits.Components.Switch switch;
      equation
        connect(ground.p, rl.n);
        connect(ground.p, capacitor.n);
        connect(ground.p, diodo.n);
        connect(ground.p, u.n);
        connect(u.p, switch.n);
        connect(switch.p, diodo.p);
        connect(diodo.p, inductor.p);
        connect(inductor.n, capacitor.p);
        connect(capacitor.p, rl.p);
      end ConvertidorBuck;
    end Examples;
  end Circuits;

  package Mechanical
     
package Translational
      package Units
        type Position = Real(unit = "m");
        type Force = Real(unit = "N");
      end Units;

      package Interfaces
        import LearningLib.Mechanical.Translational.Units.*;

        connector Flange
          Position s;
          flow Force f;
          annotation(
            Icon(graphics = {Rectangle(fillColor = {0, 118, 0}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}, coordinateSystem(initialScale = 0.1)));
        end Flange;

        // Modelo parcial que represente un objeto deformable

        partial model Compliant
          LearningLib.Mechanical.Translational.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, -4.44089e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          LearningLib.Mechanical.Translational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          Position s_rel;
          Force f;
        equation
          s_rel = flange_b.s - flange_a.s;
// positiva cuando flange_b > flange_a
          flange_b.f = f;
          flange_a.f = -f;
        end Compliant;
      end Interfaces;

      package Components
        import LearningLib.Mechanical.Translational.Units.*;
        import LearningLib.Mechanical.Translational.Interfaces.*;
        // Punto Fijo

        model Fixed
          LearningLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {2, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {1.55431e-15, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Position s_0 = 0;
        equation
          flange.s = s_0;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{40, -40}, {0, -80}}, color = {0, 127, 0}), Line(points = {{-40, -40}, {-80, -80}}, color = {0, 127, 0}), Line(points = {{-80, -40}, {80, -40}}, color = {0, 127, 0}), Line(points = {{0, -40}, {0, -10}}, color = {0, 127, 0}), Line(points = {{80, -40}, {40, -80}}, color = {0, 127, 0}), Line(points = {{0, -40}, {-40, -80}}, color = {0, 127, 0}), Text(textColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name")}));
        end Fixed;

        // Masa puntual

        model Mass
          LearningLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -4.44089e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Real m(unit = "Kg") = 1;
          Position s;
          Real v(unit = "m/s");
          Force f;
        equation
          s = flange.s;
          f = flange.f;
          m*der(v) - f = 0;
          der(s) - v = 0;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 45}}, textString = "%name"), Text(extent = {{-150, -45}, {150, -75}}, textString = "m=%m"), Rectangle(origin = {-2, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Sphere, extent = {{-73, -36}, {74, 36}})}));
        end Mass;

        // Resorte

        model Spring
          extends Compliant;
          parameter Real k(unit = "N/m") = 1;
          parameter Position s_rel0 = 0;
        equation
          f = k*(s_rel - s_rel0);
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Text(extent = {{-150, -45}, {150, -75}}, textString = "k=%k"), Line(points = {{-98, 0}, {-60, 0}, {-44, -30}, {-16, 30}, {14, -30}, {44, 30}, {60, 0}, {100, 0}}, color = {0, 127, 0})}));
        end Spring;

        // Amortiguador

        model Damper
          extends Compliant;
          parameter Real b(unit = "N.s/m") = 1;
        equation
          f = b*der(s_rel);
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{-90, 0}, {100, 0}}, color = {0, 127, 0}), Line(visible = false, points = {{-100, -100}, {-100, -20}, {-14, -20}}, color = {191, 0, 0}, pattern = LinePattern.Dot), Text(origin = {0, -8}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Line(points = {{-60, -30}, {-60, 30}}), Line(points = {{60, -30}, {-60, -30}, {-60, 30}, {60, 30}}, color = {0, 127, 0}), Rectangle(lineColor = {0, 127, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-60, 30}, {30, -30}}), Text(extent = {{-150, -45}, {150, -75}}, textString = "b=%b")}));
        end Damper;

        // Fuerza Constante

        model ConstForce
          LearningLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          parameter Force F = 1;
        equation
          flange.f = -F;
          annotation(
            Diagram,
            Icon(graphics = {Text(origin = {4, -58}, extent = {{-98, 16}, {98, -16}}, textString = "F=%F"), Text(origin = {-2, -6}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name"), Polygon(origin = {40, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{-100, 10}, {14, 10}, {14, 27}, {60, 0}, {14, -27}, {14, -10}, {-100, -10}, {-100, 10}}), Line(origin = {-77, 0}, points = {{17, 0}, {-17, 0}, {-17, 0}})}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end ConstForce;

        model ModulatedForce
          LearningLib.Mechanical.Translational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-98, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -1.55431e-15}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
          LearningLib.ControlSystems.Blocks.Interfaces.RealInput u annotation(
            Placement(visible = true, transformation(origin = {0, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2.22045e-16, 60}, extent = {{-16, -16}, {16, 16}}, rotation = -90)));
        equation
          flange.f = -u;
          annotation(
            Icon(graphics = {Polygon(origin = {40, 0}, lineColor = {0, 127, 0}, fillColor = {160, 215, 160}, fillPattern = FillPattern.Solid, points = {{-100, 10}, {14, 10}, {14, 27}, {60, 0}, {14, -27}, {14, -10}, {-100, -10}, {-100, 10}}), Line(origin = {-77, 0}, points = {{17, 0}, {-17, 0}, {-17, 0}}), Text(origin = {-2, -126}, textColor = {0, 0, 255}, extent = {{-150, 90}, {150, 50}}, textString = "%name")}));
        end ModulatedForce;
      end Components;

      package Examples
        model MasaResorteAmortiguador
          Components.Fixed fixed annotation(
            Placement(transformation(origin = {-60, -10}, extent = {{-10, -10}, {10, 10}})));
          Components.Damper damper annotation(
            Placement(transformation(origin = {-20, 2}, extent = {{-10, -10}, {10, 10}})));
          Components.Spring spring annotation(
            Placement(transformation(origin = {-20, -20}, extent = {{-10, -10}, {10, 10}})));
          Components.Mass mass(m = 10) annotation(
            Placement(transformation(origin = {20, -10}, extent = {{-10, -10}, {10, 10}})));
        equation
          connect(spring.flange_b, mass.flange) annotation(
            Line(points = {{-10, -20}, {0, -20}, {0, -10}, {20, -10}}));
          connect(damper.flange_b, mass.flange) annotation(
            Line(points = {{-10, 2}, {0, 2}, {0, -10}, {20, -10}}));
          connect(damper.flange_a, fixed.flange) annotation(
            Line(points = {{-30, 2}, {-40, 2}, {-40, -10}, {-60, -10}}));
          connect(spring.flange_a, fixed.flange) annotation(
            Line(points = {{-30, -20}, {-40, -20}, {-40, -10}, {-60, -10}}));
        end MasaResorteAmortiguador;
      end Examples;
    end Translational;

    package Rotational
      package Units
        type Angle = Real(unit = "rad");
        type Torque = Real(unit = "N.m");
      end Units;
    
      package Interfaces
        import LearningLib.Mechanical.Rotational.Units.*;
    
        connector Flange
          Angle phi;
          flow Torque tau;
          annotation(
            Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(fillColor = {193, 193, 193}, fillPattern = FillPattern.Solid, extent = {{-80, 80}, {80, -80}})}));
        end Flange;
    
        partial model Compliant
          LearningLib.Mechanical.Rotational.Interfaces.Flange flange_b annotation(
            Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {99, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          LearningLib.Mechanical.Rotational.Interfaces.Flange flange_a annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-101, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
          Angle phi_rel;
          Torque tau;
        equation
          phi_rel = flange_b.phi - flange_a.phi;
          flange_b.tau = tau;
          flange_a.tau = -tau;
        end Compliant;
      end Interfaces;
    
      package Components
        import LearningLib.Mechanical.Rotational.Units.*;
        import LearningLib.Mechanical.Rotational.Interfaces.*;
    
        model Fixed
          parameter Angle phi_0 = 0;
          LearningLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {2.22045e-16, 8.88178e-16}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
        equation
          flange.phi = phi_0;
          annotation(
            Icon(graphics = {Line(points = {{-80, -40}, {80, -40}}), Text(textColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name"), Line(points = {{80, -40}, {40, -80}}), Line(points = {{-40, -40}, {-80, -80}}), Line(points = {{40, -40}, {0, -80}}), Line(points = {{0, -40}, {0, -10}}), Line(points = {{0, -40}, {-40, -80}})}));
        end Fixed;
    
        model Inertia
          LearningLib.Mechanical.Rotational.Interfaces.Flange flange annotation(
            Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-98, -8.88178e-16}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
          parameter Real J(unit = "Kg.m2") = 1;
          Angle phi;
          Real w(unit = "rad/s");
          Torque tau;
        equation
          phi = flange.phi; // Angulo del conector
          tau = flange.tau; // Torque del conector
          J*der(w) - tau = 0;
          der(phi) - w = 0;
          annotation(
            Icon(graphics = {Text(origin = {5, 118}, extent = {{-105, 18}, {105, -18}}, textString = "J=%J"), Rectangle(origin = {17, -4}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-57, 104}, {43, -96}}, radius = 20), Rectangle(origin = {-17, 63}, fillColor = {238, 238, 238}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-83, -49}, {-23, -77}}), Text(origin = {6, -184}, textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name")}, coordinateSystem(initialScale = 0.1, extent = {{-100, -100}, {100, 100}})));
        end Inertia;
    
        model Spring
          extends LearningLib.Mechanical.Rotational.Interfaces.Compliant;
          parameter Real k(unit = "N.m/rad") = 1;
          parameter Angle phi_rel0 = 0; // phi_rel0 es como el L0
        equation
          tau = k*(phi_rel - phi_rel0);
          annotation(
            Icon(graphics = {Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name"), Line(points = {{-100, 0}, {-58, 0}, {-43, -30}, {-13, 30}, {17, -30}, {47, 30}, {62, 0}, {100, 0}}), Text(origin = {9, -12}, extent = {{-141, -34}, {141, -68}}, textString = "k=%k")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})));
        end Spring;
    
        model Damper
          extends LearningLib.Mechanical.Rotational.Interfaces.Compliant;
          parameter Real b(unit = "N.m.s/rad") = 1;
        equation
          tau = b*der(phi_rel);
          annotation(
            Icon(graphics = {Line(visible = false, points = {{-100, -100}, {-100, -40}, {-20, -40}, {-20, 0}}, color = {191, 0, 0}, pattern = LinePattern.Dot), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-60, 30}, {30, -30}}), Line(points = {{-60, 30}, {60, 30}}), Line(points = {{-90, 0}, {-60, 0}}), Line(points = {{-60, -30}, {-60, 30}}), Text(textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name"), Line(points = {{-60, -30}, {60, -30}}), Text(extent = {{-150, -50}, {150, -90}}, textString = "b=%b"), Line(points = {{30, 0}, {90, 0}})}));
        end Damper;
    
        model ConstTorque
          extends LearningLib.Mechanical.Rotational.Interfaces.Compliant;
          parameter Real Tau(unit = "N.m") = 1;
        equation
          tau = -Tau;
          annotation(
            Icon(graphics = {Text(origin = {-4, 80}, extent = {{-96, 16}, {96, -16}}, textString = "Tau=%Tau"), Line(origin = {74.38, -0.191319}, points = {{-14, 0}, {14, 0}}, thickness = 0.5), Line(origin = {-74.6161, -0.292183}, points = {{-14, 0}, {14, 0}}, thickness = 0.5), Line(origin = {-38.81, -0.53}, points = {{-18.6464, 41}, {21.3536, 1}, {-20.6464, -41}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10, smooth = Smooth.Bezier), Line(origin = {39.2395, 0.441271}, rotation = 180, points = {{-18.6464, 41}, {21.3536, 1}, {-20.6464, -41}}, thickness = 0.5, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10, smooth = Smooth.Bezier), Text(origin = {-4, -154}, textColor = {0, 0, 255}, extent = {{-150, 80}, {150, 40}}, textString = "%name")}, coordinateSystem(initialScale = 0.1)));
        end ConstTorque;
      end Components;
    
      package Examples
        import LearningLib.Mechanical.Rotational.Components.*;
    
        model SpringDamperInertia
          LearningLib.Mechanical.Rotational.Components.Fixed fixed annotation(
            Placement(transformation(origin = {-40, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
          LearningLib.Mechanical.Rotational.Components.Inertia inertia(J = 0.009, phi(start = 1), w(start = 0.2)) annotation(
            Placement(transformation(origin = {56, 0}, extent = {{-10, -10}, {10, 10}})));
          LearningLib.Mechanical.Rotational.Components.Spring spring(k = 2.7114) annotation(
            Placement(transformation(origin = {0, 12}, extent = {{-10, -10}, {10, 10}})));
          LearningLib.Mechanical.Rotational.Components.Damper damper(b = 0.04) annotation(
            Placement(transformation(origin = {0, -12}, extent = {{-10, -10}, {10, 10}})));
        equation
          connect(spring.flange_b, damper.flange_b) annotation(
            Line(points = {{9.9, 11.9}, {15.9, 11.9}, {15.9, -12.1}, {9.9, -12.1}}));
          connect(spring.flange_b, inertia.flange) annotation(
            Line(points = {{9.9, 11.9}, {15.9, 11.9}, {15.9, 0}, {46, 0}}));
          connect(spring.flange_a, damper.flange_a) annotation(
            Line(points = {{-10.1, 11.9}, {-16.1, 11.9}, {-16.1, -12.1}, {-10.1, -12.1}}));
          connect(fixed.flange, spring.flange_a) annotation(
            Line(points = {{-40, 0}, {-16, 0}, {-16, 12}, {-10, 12}}));
        end SpringDamperInertia;
      end Examples;
    end Rotational;

    package RotoTranslational
  package Components
  model RackPinion
    LearningLib.Mechanical.Translational.Interfaces.Flange flangeT annotation(
            Placement(visible = true, transformation(origin = {-100, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -70}, extent = {{-18, -18}, {18, 18}}, rotation = 0)));
    LearningLib.Mechanical.Rotational.Interfaces.Flange flangeR annotation(
            Placement(visible = true, transformation(origin = {0, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-21, -1}, extent = {{-15, -15}, {15, 15}}, rotation = 0)));
    parameter Real r(unit = "m") = 1 "Pinion radius";
    parameter Real s_0(unit = "m") = 0 "Position s when angle phi=0";
  equation
    flangeT.s - s_0 = r*flangeR.phi;
    r*flangeT.f = -flangeR.tau;
    annotation(
            Icon(graphics = {Line(origin = {-79.4754, -70.0239}, points = {{6, 0}, {-6, 0}, {6, 0}}), Text(origin = {48, -8}, extent = {{-150, 50}, {150, 80}}, textString = "r=%r"), Rectangle(fillColor = {72, 143, 0}, fillPattern = FillPattern.Solid, extent = {{-74.41, -80}, {106.59, -60}}), Polygon(origin = {-20, 0}, rotation = 10, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-5.3473, 43.0304}, {-10, 10}, {-45, 5}, {-45, -5}, {-10, -10}, {-5, -45}, {5, -45}, {10, -10}, {41.0608, -4.30541}, {41.0608, 5.69459}, {10, 10}, {4.6527, 43.0304}, {-5.3473, 43.0304}}), Polygon(origin = {-20, 0}, rotation = 55, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-5, 45}, {-10, 10}, {-45, 5}, {-45, -5}, {-10, -10}, {-5, -45}, {5, -45}, {10, -10}, {43.3617, -6.14715}, {43.3617, 3.85285}, {10, 10}, {5, 45}, {-5, 45}}), Polygon(origin = {16.88, -50}, fillColor = {66, 132, 0}, fillPattern = FillPattern.Solid, points = {{-84.375, -10}, {-79.375, 10}, {-69.375, 10}, {-64.375, -10}, {-54.375, -10}, {-49.375, 10}, {-39.375, 10}, {-34.375, -10}, {-24.375, -10}, {-19.375, 10}, {-9.375, 10}, {-4.375, -10}, {5.625, -10}, {10.625, 10}, {20.625, 10}, {25.625, -10}, {35.625, -10}, {40.625, 10}, {50.625, 10}, {55.625, -10}, {65.625, -10}, {70.625, 10}, {78.125, 10}, {78.125, -10}, {-84.375, -10}}), Ellipse(origin = {-21, -1}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-29, -29}, {29, 29}}), Text(origin = {0, -222}, textColor = {0, 0, 255}, extent = {{-150, 85}, {150, 125}}, textString = "%name")}));
  end RackPinion;
      end Components;
    end RotoTranslational;
  end Mechanical;
end LearningLib;
