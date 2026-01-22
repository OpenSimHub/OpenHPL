within OpenHPLTest;
model HPLinTest
  extends Modelica.Icons.Example;
  OpenHPLTest.HPLiniarizationKPFran hpl;
  parameter Real t_ramp = 600, u_start = 0.7493, u_end = 0.7;
  Real u;
equation
  u = if time < t_ramp then u_start else u_end;
  hpl.u = u;
end HPLinTest;
