within OpenHPLTest;

package TestPipe
  extends Modelica.Icons.ExamplesPackage;

  partial model AbstractTest
    extends Modelica.Icons.Example;
    //
    inner OpenHPL.Data data(Vdot_0 = 0.0, p_a = 0.0, p_eps = 0.0) annotation(
      Placement(transformation(origin = {-72, 80}, extent = {{-10, -10}, {10, 10}})));
    //
    parameter Modelica.Units.SI.Length Ln = 1000.;
    parameter Modelica.Units.SI.Length Dn = sqrt(A*4/Modelica.Constants.pi);
    Real error;
    OpenHPL.Waterway.Reservoir Upstream(h_0 = 100, constantLevel = true) annotation(
      Placement(transformation(origin = {-54, 32}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Reservoir Downstream(constantLevel = true, h_0 = 0) annotation(
      Placement(transformation(origin = {72, 10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  protected
    constant Modelica.Units.SI.Area A = 0.1;
  end AbstractTest;

  model Test01
    extends AbstractTest;
    OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = 0.8*Dn, D_o = 1.2*Dn, SteadyState = true) annotation(
      Placement(transformation(origin = {2, 68}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn, D_o = Dn, SteadyState = true) annotation(
      Placement(transformation(origin = {2, 40}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = 1.2*Dn, D_o = 0.8*Dn, SteadyState = true) annotation(
      Placement(transformation(origin = {0, 8}, extent = {{-10, -10}, {10, 10}})));
  equation
   error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
    connect(Upstream.o, pipe1.i) annotation(
      Line(points = {{-44, 32}, {-34, 32}, {-34, 68}, {-8, 68}}, color = {0, 128, 255}));
    connect(pipe1.o, Downstream.o) annotation(
      Line(points = {{12, 68}, {38, 68}, {38, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(pipe2.o, Downstream.o) annotation(
      Line(points = {{12, 40}, {26, 40}, {26, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(pipe3.o, Downstream.o) annotation(
      Line(points = {{10, 8}, {20, 8}, {20, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(Upstream.o, pipe2.i) annotation(
      Line(points = {{-44, 32}, {-26, 32}, {-26, 40}, {-8, 40}}, color = {0, 128, 255}));
    connect(Upstream.o, pipe3.i) annotation(
      Line(points = {{-44, 32}, {-32, 32}, {-32, 8}, {-10, 8}}, color = {0, 128, 255}));
  annotation(
      experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
end Test01;
  
  model Test02
    extends AbstractTest;
    OpenHPL.Waterway.Pipe pipe1(H = 0, L = Ln, D_i = 0.8*Dn, D_o = 1.2*Dn) annotation(
      Placement(transformation(origin = {2, 68}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe2(H = 0, L = Ln, D_i = Dn, D_o = Dn) annotation(
      Placement(transformation(origin = {2, 40}, extent = {{-10, -10}, {10, 10}})));
    OpenHPL.Waterway.Pipe pipe3(H = 0, L = Ln, D_i = 1.2*Dn, D_o = 0.8*Dn) annotation(
      Placement(transformation(origin = {0, 8}, extent = {{-10, -10}, {10, 10}})));
  equation
   error=sqrt((pipe1.mdot-pipe2.mdot)^2 + (pipe2.mdot-pipe3.mdot)^2 + (pipe3.mdot-pipe1.mdot)^2);
    connect(Upstream.o, pipe1.i) annotation(
      Line(points = {{-44, 32}, {-34, 32}, {-34, 68}, {-8, 68}}, color = {0, 128, 255}));
    connect(pipe1.o, Downstream.o) annotation(
      Line(points = {{12, 68}, {38, 68}, {38, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(pipe2.o, Downstream.o) annotation(
      Line(points = {{12, 40}, {26, 40}, {26, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(pipe3.o, Downstream.o) annotation(
      Line(points = {{10, 8}, {20, 8}, {20, 10}, {62, 10}}, color = {0, 128, 255}));
    connect(Upstream.o, pipe2.i) annotation(
      Line(points = {{-44, 32}, {-26, 32}, {-26, 40}, {-8, 40}}, color = {0, 128, 255}));
    connect(Upstream.o, pipe3.i) annotation(
      Line(points = {{-44, 32}, {-32, 32}, {-32, 8}, {-10, 8}}, color = {0, 128, 255}));
  annotation(
      experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.004));
end Test02;
  
end TestPipe;
