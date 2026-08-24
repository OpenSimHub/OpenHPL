within OpenHPLTest.EmpiricalTurbine.TurbineTest;
model Test01_Turbine
  extends Modelica.Icons.Example;
   inner OpenHPL.Data data annotation (
    Placement(transformation(origin={-80,80}, extent = {{-10, -10}, {10, 10}})));
   parameter SI.Height Hn=100;
   parameter Real opening=0.2;

  OpenHPL.Waterway.Reservoir overvann(h_0 = Hn, constantLevel = true) annotation (
    Placement(transformation(origin={-50,10}, extent = {{-10, -10}, {10, 10}})));
  OpenHPL.Waterway.Reservoir undervann(h_0 = 0, constantLevel = true) annotation (
    Placement(transformation(origin={50,-10}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
  OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine( H_n = Hn, P_n = 1e7, p = 18, enable_f = true, f_0 = 0) annotation (
    Placement(transformation( extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 0) annotation(
    Placement(transformation(origin={-30,80}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(overvann.o, turbine.i) annotation(
    Line(points={{-40,10},{-18,10},{-18,0},{-10,0}}, color = {0, 128, 255}));
  connect(turbine.o, undervann.o) annotation(
    Line(points={{10,0},{34,0},{34,-10},{40,-10}}, color = {0, 128, 255}));
  connect(ramp.y, turbine.u_t) annotation(
    Line(points={{-19,80},{-8,80},{-8,12}}, color = {0, 0, 127}));
  annotation (
    Documentation(info="<html>
<p>Basic test of EpiricalTurbine model. Opening is kept constant.</p>
<p>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.</p>
</html>"),
    experiment(StartTime = 0, StopTime = 30, Tolerance = 1e-06, Interval = 0.001));

end Test01_Turbine;
