within OpenHPL.Waterway;
model test
  extends Modelica.Icons.UnderConstruction;
  outer Constants Const;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Height H = 25 "Height over which water fall in the pipe";
  parameter Modelica.SIunits.Length L = 6600 "Length of the pipe";
  parameter Modelica.SIunits.Diameter D = 5.8 "Diametr from the input side of the pipe";
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 10 "Initial flow rate in the pipe";
  parameter Modelica.SIunits.Temperature T_i = 273 + 5 "initial temperature";
  parameter Modelica.SIunits.SpecificHeatCapacity c_p = 4200;
  Modelica.SIunits.Mass m;
  Modelica.SIunits.Area A = D ^ 2 * pi / 4;
  Real cos_theta = H / L;
  Modelica.SIunits.Velocity v;
  Modelica.SIunits.Momentum M;
  parameter Modelica.SIunits.Pressure p_1 = 11e5;
  //, p_2 = p_1 + Const.rho * Const.g * H;
  Modelica.SIunits.VolumeFlowRate V_dot;
  Modelica.SIunits.Temperature T;
  Real F_f, W_f, W_e, p_2, dp, C_v = 3, u_t;
  //, W_v;
initial equation
  der(V_dot) = 0;
  der(T) = 0;
equation
  u_t = if time < 20 then 2 else 1;
  // Water velocity
  v = V_dot / A;
  // Momentum and mass of water
  M = Const.rho * L * V_dot;
  m = Const.rho * A * L;
  // Friction force
  F_f = Functions.DarcyFriction.Friction(v, D, L, Const.rho, Const.mu, Const.eps);
  // momentum balance
  der(M) = (p_1 - p_2) * A - F_f + m * Const.g * cos_theta;
  dp = V_dot ^ 2 * Const.p_a / (C_v * u_t) ^ 2;
  dp = p_2 - Const.p_a;
  W_f = -F_f * v;
  W_e = V_dot * (p_1 - p_2);
  ////
  c_p * m * der(T) = V_dot * Const.rho * c_p * (T_i - T) + W_e - W_f;
end test;
