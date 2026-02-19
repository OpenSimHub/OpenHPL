within OpenHPLTest;

package TestPipe
  extends Modelica.Icons.ExamplesPackage;

  partial model AbstractTest
    extends Modelica.Icons.Example;
    //
    inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps = 0.0) annotation(
      Placement(transformation(origin = {-70, 70}, extent = {{-10, -10}, {10, 10}})));
    //
    parameter Modelica.Units.SI.Length Ln = 1000.;
    parameter Modelica.Units.SI.Length Dn = sqrt(A*4/Modelica.Constants.pi);
    Real error;
    OpenHPL.Waterway.Reservoir Upstream(h_0 = 100, constantLevel = true) annotation(
      Placement(transformation(origin = {-50, 30}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Reservoir Downstream(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {70, 10}, extent = {{10, -10}, {-10, 10}})));
  protected
    constant Modelica.Units.SI.Area A = 0.1;
  end AbstractTest;

  model Test01
    extends AbstractTest;
    OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = 0.8*Dn, D_o = 1.2*Dn) annotation(
      Placement(transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn, D_o = Dn) annotation(
      Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = 1.2*Dn, D_o = 0.8*Dn) annotation(
      Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  equation
   error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
  connect(Upstream.o, pipe1.i) annotation(
      Line(points = {{-40, 30}, {-20, 30}, {-20, 60}, {-10, 60}}, color = {0, 128, 255}));
  connect(pipe2.i, Upstream.o) annotation(
      Line(points = {{-10, 30}, {-40, 30}}, color = {0, 128, 255}));
  connect(Upstream.o, pipe3.i) annotation(
      Line(points = {{-40, 30}, {-20, 30}, {-20, 0}, {-10, 0}}, color = {0, 128, 255}));
  connect(pipe1.o, Downstream.o) annotation(
      Line(points = {{10, 60}, {50, 60}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
  connect(pipe2.o, Downstream.o) annotation(
      Line(points = {{10, 30}, {50, 30}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
  connect(pipe3.o, Downstream.o) annotation(
      Line(points = {{10, 0}, {50, 0}, {50, 10}, {60, 10}}, color = {0, 128, 255}));
  annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test01;

  model Test02
    extends OpenHPLTest.TestPipe.Test01(data(SteadyState = true));
  equation

  end Test02;

  model Test03
     extends AbstractTest(data(SteadyState = true));
     
     OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = Dn) annotation(
      Placement(transformation(origin = {0, 60}, extent = {{-10, -10}, {10, 10}})));
     OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn) annotation(
      Placement(transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}})));
     OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = Dn) annotation(  Placement(transformation(extent = {{-10, -10}, {10, 10}})));
   OpenHPL.Waterway.Valve valve1(ValveCapacity = false, H_n = 100, Vdot_n = 1)  annotation(
      Placement(transformation(origin = {30, 60}, extent = {{-10, -10}, {10, 10}})));
     OpenHPL.Waterway.Valve valve2(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation(
      Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
     OpenHPL.Waterway.Valve valve3(ValveCapacity = false, H_n = 100, Vdot_n = 1) annotation(
      Placement(transformation(origin = {30, 0}, extent = {{-10, 10}, {10, -10}})));
    Modelica.Blocks.Sources.Ramp ramp1(height = 1, duration = 5, offset = 0, startTime = 2)  annotation(
      Placement(transformation(origin = {80, 80}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    Modelica.Blocks.Sources.Ramp ramp2(duration = 5, height = 0.5, offset = 0.5, startTime = 2) annotation(
      Placement(transformation(origin = {80, 50}, extent = {{10, -10}, {-10, 10}})));
    Modelica.Blocks.Sources.Ramp ramp3(duration = 5, height = -1, offset = 1, startTime = 2) annotation(
      Placement(transformation(origin = {80, -20}, extent = {{10, -10}, {-10, 10}})));
  equation
  error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
  connect(pipe1.o, valve1.i) annotation(
      Line(points = {{10, 60}, {20, 60}}, color = {0, 128, 255}));
  connect(pipe2.o, valve2.i) annotation(
      Line(points = {{10, 30}, {20, 30}}, color = {0, 128, 255}));
  connect(pipe3.o, valve3.i) annotation(
      Line(points = {{10, 0}, {20, 0}}, color = {0, 128, 255}));
  connect(ramp1.y, valve1.opening) annotation(
      Line(points = {{69, 80}, {30, 80}, {30, 68}}, color = {0, 0, 127}));
  connect(valve1.o, Downstream.o) annotation(
      Line(points = {{40, 60}, {52, 60}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
  connect(valve2.o, Downstream.o) annotation(
      Line(points = {{40, 30}, {52, 30}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
  connect(ramp3.y, valve3.opening) annotation(
      Line(points = {{69, -20}, {30, -20}, {30, -8}}, color = {0, 0, 127}));
  connect(valve3.o, Downstream.o) annotation(
      Line(points = {{40, 0}, {52, 0}, {52, 10}, {62, 10}}, color = {0, 128, 255}));
  connect(valve2.opening, ramp2.y) annotation(
      Line(points = {{30, 38}, {30, 50}, {70, 50}}, color = {0, 0, 127}));
  connect(Upstream.o, pipe2.i) annotation(
      Line(points = {{-40, 30}, {-10, 30}}, color = {0, 128, 255}));
  connect(Upstream.o, pipe1.i) annotation(
      Line(points = {{-40, 30}, {-20, 30}, {-20, 60}, {-10, 60}}, color = {0, 128, 255}));
  connect(Upstream.o, pipe3.i) annotation(
      Line(points = {{-40, 30}, {-20, 30}, {-20, 0}, {-10, 0}}, color = {0, 128, 255}));
  annotation(
      experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));
end Test03;

end TestPipe;