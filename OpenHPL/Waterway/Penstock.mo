within OpenHPL.Waterway;
model Penstock "Model of the penstock with elastic walls and compressible water. Simple Staggered grid scheme"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  import Modelica.Constants.pi;
  // Penstock
  parameter Modelica.SIunits.Height H = 420 "Height over which water fall in the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 600 "length of the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_i = 3.3 "Diametr from the input side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D_o = D_i "Diametr from the output side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = 20 "initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20 "Number of segments" annotation (
    Dialog(group = "Discretization"));
  Modelica.SIunits.Diameter dD = 0.5 * (D_i + D_o), D[N] = linspace(D_i + dD / 2, D_o - dD / 2, N), D_[N + 1] = linspace(D_i, D_o, N + 1);
  Modelica.SIunits.Area A[N] = D .^ 2 * pi / 4, A_[N + 1] = D_ .^ 2 * pi / 4, A_m[N - 2], A_m_end, A_m_first;
  Modelica.SIunits.Pressure p_i, p_o, p_[N - 1], dp = data.rho * data.g * H / N, p_m[N - 2];
  Modelica.SIunits.Length dx = L / N, Per_m[N - 2];
  Modelica.SIunits.MassFlowRate mdot_R, mdot_V, mdot[N - 2], m_exp[N];
  Real F_ap[N - 1], F_m[N - 2], F_exp[N], p_eps_m[N - 2], Ap_m[3, N - 2], F_m_end, F_m_first;
  Modelica.SIunits.Force F_g[N - 2], F_p[N - 2];
  Modelica.SIunits.Density rho_m[N - 2], rho_m_end, rho_m_first;
  Modelica.SIunits.Velocity v_exp[N];
  Modelica.SIunits.VolumeFlowRate V_p_out[N - 2], V_p_out_end;
  extends OpenHPL.Interfaces.TwoContact;
initial equation
  mdot_R = data.rho * Vdot_0;
  mdot_V = data.rho * Vdot_0;
  mdot = data.rho * Vdot_0 * ones(N - 2);
  p_ = p_i + dp:dp:p_i + dp * (N - 1);
equation
  // Pipe flow rate
  mdot_R = i.mdot;
  mdot_V = -o.mdot;
  // pipe presurre
  p_i = i.p;
  p_o = o.p;
  // momentum balance for the first and last segment
  F_m_first = data.rho * A[1] * (1 + data.beta_total * ((p_[1] + p_i) / 2 - data.p_a));
  rho_m_first = data.rho * (1 + data.beta * ((p_[1] + p_i) / 2 - data.p_a));
  A_m_first = F_m_first / rho_m_first;
  dx * der(mdot_R) = A_m_first * (p_i - p_[1]) + F_m_first * data.g * dx * H / L - Functions.DarcyFriction.Friction(v_exp[1], 2 * sqrt(A_m_first / pi), dx, rho_m_first, data.mu, data.p_eps);
  F_m_end = data.rho * A[N] * (1 + data.beta_total * ((p_[N - 1] + p_o) / 2 - data.p_a));
  rho_m_end = data.rho * (1 + data.beta * ((p_[N - 1] + p_o) / 2 - data.p_a));
  A_m_end = F_m_end / rho_m_end;
  dx * der(mdot_V) = (-A_m_end * (p_o - p_[N - 1])) + F_m_end * data.g * dx * H / L - Functions.DarcyFriction.Friction(v_exp[N], 2 * sqrt(A_m_end / pi), dx, rho_m_end, data.mu, data.p_eps);
  // mass flow rate vector with all segments
  m_exp[1] = mdot_R;
  m_exp[2:N - 1] = mdot[:];
  m_exp[N] = mdot_V;
  // mass balance for pressure
  dx * data.rho * A_[2:N] .* data.beta_total .* der(p_) = m_exp[1:N - 1] - m_exp[2:N];
  // define middle pressures, densities and areas
  F_ap = data.rho * A_[2:N] .* (ones(N - 1) + data.beta_total * (p_ - data.p_a * ones(N - 1)));
  F_m = (F_ap[1:N - 2] + F_ap[2:N - 1]) / 2;
  F_exp[1] = data.rho * A_[1] * (1 + data.beta_total * (p_i - data.p_a));
  //F_m_first;
  F_exp[2:N - 1] = F_m[:];
  F_exp[N] = data.rho * A_[N + 1] * (1 + data.beta_total * (p_o - data.p_a));
  //F_m_end;
  v_exp = m_exp ./ F_exp;
  p_m = (p_[1:N - 2] + p_[2:N - 1]) / 2;
  rho_m = data.rho * (ones(N - 2) + data.beta * (p_m - data.p_a * ones(N - 2)));
  A_m = F_m ./ rho_m;
  Per_m = sqrt(4 * pi * A_m);
  // gravity and pressure drop forces
  F_g = dx * data.g * H / L * F_exp[2:N - 1];
  F_p = A_m .* (p_[1:N - 2] - p_[2:N - 1]);
  // friction and other coefficients
  for i in 1:N - 2 loop
    p_eps_m[i] = -Functions.DarcyFriction.Friction(v_exp[i + 1], 2 * sqrt(A_m[i] / pi), dx, rho_m[i], data.mu, data.p_eps) / v_exp[i + 1];
    Ap_m[1, i] = -((m_exp[i] - m_exp[i + 2]) / 4 - p_eps_m[i]);
    Ap_m[2, i] = (m_exp[i] + m_exp[i + 1]) / 4;
    Ap_m[3, i] = -(m_exp[i + 1] + m_exp[i + 2]) / 4;
  end for;
  // momentum balance
  dx * der(mdot) = Ap_m[1, :] .* v_exp[2:N - 1] + Ap_m[2, :] .* v_exp[1:N - 2] + Ap_m[3, :] .* v_exp[3:N] + F_g + F_p;
  // volumetric flow rates for all cells
  V_p_out = mdot ./ rho_m;
  V_p_out_end = mdot_V / (data.rho * (1 + data.beta * (p_o - data.p_a)));
  annotation (
    Documentation(info = "<html><head></head><body><p>This is a more detaied model of the pipe that can be use for proper modeling of penstock. (This model does not work well. Instead PenstockKP model can be used.)</p><p>The model for the penstock with the elastic walls and compressible water with simple discretization method (Staggered grid). The geometry of the penstock is described due to figure:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/penstock.png\"></p>
<p>Conservation laws are usually solved by Finite-volume methods. With the Finite volume method, we divide the grid into small control volumes or control cells and then apply the conservation laws. The discretization method is based on Staggered grid scheme, where the penstock is divided in <i>N</i> segments, with input and output pressure as a boundary conditions. Can be describe as the follow figure:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/besad.png\"></p>
</body></html>"));
end Penstock;
