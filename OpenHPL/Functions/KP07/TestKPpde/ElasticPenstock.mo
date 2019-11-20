within OpenHPL.Functions.KP07.TestKPpde;
model ElasticPenstock
  extends Modelica.Icons.Example;
  outer Parameters Const;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Height H = 420 "Height over which water fall in the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 600 "length of the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.3 "Diametr of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 20 "initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20 "Number of segments";
  Modelica.SIunits.Area A_atm = D ^ 2 * pi / 4 "pipe are at atm. p.", A[N] "center pipe A", A_[N, 4] "bounds pipe A";
  Modelica.SIunits.Pressure p_p[N] "center pressure", dp = Const.rho * Const.g * H / N "initial p. step", p_1 = 8e5 "input p.", p_2 = 48e5 "output p.", p_[N, 4] "bounds p.";
  Modelica.SIunits.Length dx = L / N "length step", B[N + 4] = zeros(N + 4) "additional for open channel";
  Modelica.SIunits.MassFlowRate m_dot[N] "center mass flow", m_dot_[N, 4] "bounds mass flow", m_dot_R = V_dot0 * Const.rho "input m_dot", m_dot_V = V_dot0 * Const.rho "output m_dot";
  Real F_ap[N] "centered A*rho", S_[2 * N] "source term", F_[2 * N, 4] "F matrix", lam1[N, 4] "eigenvalue '+'", lam2[N, 4] "eigenvalue '-'", F_ap_[N, 4] "bounds A*rho";
  Modelica.SIunits.Density rho[N] "centered density", rho_[N, 4] "bounds density";
  Modelica.SIunits.Velocity v_[N, 4] "bounds velocity", v[N] "centered velocity";
  Modelica.SIunits.VolumeFlowRate V_dot[N] "centered volumetric flow";
  Real theta = 1.3 "parameter for slope limiter";
  Real U_[8, N] "bounds states", U[2 * N] "center states", F_d[N] "friction";
public
  Functions.KP07.KPmethod kP(N = N, U = U, dx = dx, S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = [p_1, m_dot_R; p_2, m_dot_V], boundaryCon = [true, true; false, true]);
  // specify all variables which is needed for using KP method for solve PDE
initial equation
  m_dot = Const.rho * V_dot0 * ones(N);
  p_p = p_1 + dp / 2:dp:p_1 + dp / 2 + dp * (N - 1);
equation
  /////  define state vector
  U[1:N] = p_p[:];
  U[N + 1:2 * N] = m_dot[:];
  ///// Define variables, which are going to be used for source term S_
  F_ap = Const.rho * A_atm * (ones(N) + Const.beta_total * (p_p - Const.p_a * ones(N)));
  v = m_dot ./ F_ap;
  rho = Const.rho * (ones(N) + Const.beta * (p_p - Const.p_a * ones(N)));
  A = F_ap ./ rho;
  V_dot = m_dot ./ rho;
  ///// Define the piecewise linear reconstruction of states.
  U_ = kP.U_;
  ///// decompose matrix U into state matrix
  p_ = transpose(matrix(U_[1:2:8, :]));
  m_dot_ = transpose(matrix(U_[2:2:8, :]));
  ///// define variables, which are going to be used for F matrix and eigenvalues
  rho_ = Const.rho * (ones(N, 4) + Const.beta * (p_ - Const.p_a * ones(N, 4)));
  F_ap_ = Const.rho * A_atm * (ones(N, 4) + Const.beta_total * (p_ - Const.p_a * ones(N, 4)));
  A_ = F_ap_ ./ rho_;
  v_ = m_dot_ ./ F_ap_;
  ///// define eigenvalues
  lam1 = (v_ + sqrt(v_ .* v_ + 4 * A_ / Const.rho ./ A_atm / Const.beta_total)) / 2;
  lam2 = (v_ - sqrt(v_ .* v_ + 4 * A_ / Const.rho ./ A_atm / Const.beta_total)) / 2;
  ///// F vector
  F_ = [m_dot_ ./ Const.rho ./ A_atm ./ Const.beta_total; m_dot_ .* v_ + A_ .* p_];
  ///// source term of friction and gravity forces
  for i in 1:N loop
    // define friction force in each segment using Darcy friction factor
    F_d[i] = DarcyFriction.Friction(v[i], 2 * sqrt(A[i] / pi), dx, rho[i], Const.mu, Const.eps) / dx;
  end for;
  S_[1:N] = vector(zeros(N));
  S_[N + 1:2 * N] = vector(F_ap * Const.g * H / L - F_d);
  ///// defferential equation
  der(U) = kP.diff_eq;
  annotation (
    experiment(StopTime = 100),
    Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for penstock with compressible water and elastic walls is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term <i>S</i> and vector <i>F</i> are implemented inside this model.</p>
</html>"));
end ElasticPenstock;
