within OpenHPL.Waterway;
model Penstock "Model of the penstock with elastic walls and compressible water. Simple Staggered grid scheme"
  extends Modelica.Icons.UnderConstruction;
  outer Constants Const;
  extends OpenHPL.Icons.Pipe(    vertical=true);
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
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 20 "initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20 "Number of segments" annotation (
    Dialog(group = "Discretization"));
  Modelica.SIunits.Diameter dD = 0.5 * (D_i + D_o), D[N] = linspace(D_i + dD / 2, D_o - dD / 2, N), D_[N + 1] = linspace(D_i, D_o, N + 1);
  Modelica.SIunits.Area A[N] = D .^ 2 * pi / 4, A_[N + 1] = D_ .^ 2 * pi / 4, A_m[N - 2], A_m_end, A_m_first;
  Modelica.SIunits.Pressure p_1, p_2, p_[N - 1], dp = Const.rho * Const.g * H / N, p_m[N - 2];
  Modelica.SIunits.Length dx = L / N, Per_m[N - 2];
  Modelica.SIunits.MassFlowRate m_dot_R, m_dot_V, m_dot[N - 2], m_exp[N];
  Real F_ap[N - 1], F_m[N - 2], F_exp[N], eps_m[N - 2], Ap_m[3, N - 2], F_m_end, F_m_first;
  Modelica.SIunits.Force F_g[N - 2], F_p[N - 2];
  Modelica.SIunits.Density rho_m[N - 2], rho_m_end, rho_m_first;
  Modelica.SIunits.Velocity v_exp[N];
  Modelica.SIunits.VolumeFlowRate V_p_out[N - 2], V_p_out_end;
  extends OpenHPL.Interfaces.TwoContact;
initial equation
  m_dot_R = Const.rho * V_dot0;
  m_dot_V = Const.rho * V_dot0;
  m_dot = Const.rho * V_dot0 * ones(N - 2);
  p_ = p_1 + dp:dp:p_1 + dp * (N - 1);
equation
  // Pipe flow rate
  m_dot_R = p.m_dot;
  m_dot_V = -n.m_dot;
  // pipe presurre
  p_1 = p.p;
  p_2 = n.p;
  // momentum balance for the first and last segment
  F_m_first = Const.rho * A[1] * (1 + Const.beta_total * ((p_[1] + p_1) / 2 - Const.p_a));
  rho_m_first = Const.rho * (1 + Const.beta * ((p_[1] + p_1) / 2 - Const.p_a));
  A_m_first = F_m_first / rho_m_first;
  dx * der(m_dot_R) = A_m_first * (p_1 - p_[1]) + F_m_first * Const.g * dx * H / L - Functions.DarcyFriction.Friction(v_exp[1], 2 * sqrt(A_m_first / pi), dx, rho_m_first, Const.mu, Const.eps);
  F_m_end = Const.rho * A[N] * (1 + Const.beta_total * ((p_[N - 1] + p_2) / 2 - Const.p_a));
  rho_m_end = Const.rho * (1 + Const.beta * ((p_[N - 1] + p_2) / 2 - Const.p_a));
  A_m_end = F_m_end / rho_m_end;
  dx * der(m_dot_V) = (-A_m_end * (p_2 - p_[N - 1])) + F_m_end * Const.g * dx * H / L - Functions.DarcyFriction.Friction(v_exp[N], 2 * sqrt(A_m_end / pi), dx, rho_m_end, Const.mu, Const.eps);
  // mass flow rate vectore with all segments
  m_exp[1] = m_dot_R;
  m_exp[2:N - 1] = m_dot[:];
  m_exp[N] = m_dot_V;
  // mass balance for pressure
  dx * Const.rho * A_[2:N] .* Const.beta_total .* der(p_) = m_exp[1:N - 1] - m_exp[2:N];
  // define middle pressures, densities and areas
  F_ap = Const.rho * A_[2:N] .* (ones(N - 1) + Const.beta_total * (p_ - Const.p_a * ones(N - 1)));
  F_m = (F_ap[1:N - 2] + F_ap[2:N - 1]) / 2;
  F_exp[1] = Const.rho * A_[1] * (1 + Const.beta_total * (p_1 - Const.p_a));
  //F_m_first;
  F_exp[2:N - 1] = F_m[:];
  F_exp[N] = Const.rho * A_[N + 1] * (1 + Const.beta_total * (p_2 - Const.p_a));
  //F_m_end;
  v_exp = m_exp ./ F_exp;
  p_m = (p_[1:N - 2] + p_[2:N - 1]) / 2;
  rho_m = Const.rho * (ones(N - 2) + Const.beta * (p_m - Const.p_a * ones(N - 2)));
  A_m = F_m ./ rho_m;
  Per_m = sqrt(4 * pi * A_m);
  // gravity and pressure drop forces
  F_g = dx * Const.g * H / L * F_exp[2:N - 1];
  F_p = A_m .* (p_[1:N - 2] - p_[2:N - 1]);
  // friction and other coefficients
  for i in 1:N - 2 loop
    eps_m[i] = -Functions.DarcyFriction.Friction(v_exp[i + 1], 2 * sqrt(A_m[i] / pi), dx, rho_m[i], Const.mu, Const.eps) / v_exp[i + 1];
    Ap_m[1, i] = -((m_exp[i] - m_exp[i + 2]) / 4 - eps_m[i]);
    Ap_m[2, i] = (m_exp[i] + m_exp[i + 1]) / 4;
    Ap_m[3, i] = -(m_exp[i + 1] + m_exp[i + 2]) / 4;
  end for;
  // momentum balance
  dx * der(m_dot) = Ap_m[1, :] .* v_exp[2:N - 1] + Ap_m[2, :] .* v_exp[1:N - 2] + Ap_m[3, :] .* v_exp[3:N] + F_g + F_p;
  // volumetric flow rates for all cells
  V_p_out = m_dot ./ rho_m;
  V_p_out_end = m_dot_V / (Const.rho * (1 + Const.beta * (p_2 - Const.p_a)));
  annotation (
    Documentation(info = "<html><head></head><body><p>This is a more detaied model of the pipe that can be use for proper modeling of penstock. (This model does not work well. Instead PenstockKP model can be used.)</p><p>The model for the penstock with the elastic walls and compressible water with simple discretization method (Staggered grid). The geometry of the penstock is described due to figure:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/penstock.png\"></p>
<p>Conservation laws are usually solved by Finite-volume methods. With the Finite volume method, we divide the grid into small control volumes or control cells and then apply the conservation laws. The discretization method is based on Staggered grid scheme, where the penstock is divided in <i>N</i> segments, with input and output pressure as a boundary conditions. Can be describe as the follow figure:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/besad.png\"></p>
</body></html>"));
end Penstock;
