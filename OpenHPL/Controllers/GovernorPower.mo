within OpenHPL.Controllers;
model GovernorPower
  extends Modelica.Icons.UnderConstruction;
outer Data data;
  parameter Modelica.SIunits.Time T_p = 0.04 "pilot servomotor time constant";
  parameter Modelica.SIunits.Time T_g = 0.2 "main servomotor integration time";
  parameter Modelica.SIunits.Time T_r = 1.75 "transient droop time constant";
  parameter Real droop = 0.1 "droop";
  parameter Real delta = 0.04 "transient droop";
  parameter Real Y_gv_max = 0.05 "Max guide vane opening rate";
  parameter Real Y_gv_min = 0.2 "Max guide vane closing rate";
  parameter Modelica.SIunits.Frequency f_ref = 50 "Reference frequency";
  parameter Real a = 0.000000009215729, b = 0.012086289473684;
  Real d, x_r, u, e, Y_gv_ref = 0.9;
  Modelica.Blocks.Interfaces.RealInput P_ref annotation (
    Placement(visible = true, transformation(extent = {{-128, -20}, {-88, 20}}, rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput Y_gv annotation (
    Placement(transformation(extent = {{96, -10}, {116, 10}}), iconTransformation(extent = {{80, -20}, {120, 20}})));
  Modelica.Blocks.Interfaces.RealInput f annotation (
    Placement(transformation(extent = {{-10, -10}, {10, 10}}, rotation = 270, origin = {0, 104}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 270, origin = {3.55271e-015, 100})));
  Modelica.Blocks.Interfaces.RealInput P annotation (
    Placement(visible = true, transformation(extent = {{-128, -70}, {-88, -30}}, rotation = 0), iconTransformation(extent = {{-120, -80}, {-80, -40}}, rotation = 0)));
initial equation
  Y_gv = Y_gv_ref;
  x_r = delta * Y_gv;
  u = 0;
equation
//f = freq.f;
//Y_gv_ref = a * P_ref + b;
  d = delta * Y_gv - x_r;
  e = 1 - f / f_ref + droop * (P - P_ref) - d;
  T_r * der(x_r) + x_r = delta * Y_gv;
  T_p * der(u) + u = e;
  if Y_gv < 0 and u < 0 or Y_gv > 1 and u > 0 then
    der(Y_gv) = 0;
  elseif u / T_g >= Y_gv_max then
    der(Y_gv) = Y_gv_max;
  elseif u / T_g <= (-Y_gv_min) then
    der(Y_gv) = -Y_gv_min;
  else
    der(Y_gv) = u / T_g;
  end if;
end GovernorPower;
