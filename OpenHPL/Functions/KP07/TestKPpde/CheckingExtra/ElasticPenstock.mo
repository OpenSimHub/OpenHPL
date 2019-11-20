within OpenHPL.Functions.KP07.TestKPpde.CheckingExtra;
model ElasticPenstock
  extends Modelica.Icons.Example;
  outer Parameters Const;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Height H = 420 "Height over which water fall in the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 600 "length of the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.3 "Diametr from the input side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 20 "initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20;
  Modelica.SIunits.Area A_atm = D ^ 2 * pi / 4;
  Modelica.SIunits.Pressure p_p[N], dp = Const.rho * Const.g * H / N, p_1 = 8e5, p_2 = 48e5, p_[N, 4];
  Modelica.SIunits.Length dx = L / N, B[N + 4] = zeros(N + 4);
  Modelica.SIunits.MassFlowRate m_dot[N], m_dot_[N, 4], m_dot_R = V_dot0 * Const.rho, m_dot_V = V_dot0 * Const.rho;
  Real U_[8, N], S_[2 * N], F_[2 * N, 4], lam1[N, 4], lam2[N, 4];
  Modelica.SIunits.VolumeFlowRate V_dot[N];
  Real theta = 1.3;
  Real U[2 * N], F_d[N];
public
  BasicEquation basic(N = N, U = U, rho_atm = Const.rho, A_atm = A_atm * ones(N), beta_total = Const.beta_total, beta = Const.beta, p_a = Const.p_a);
  // use this model for define main equations for specific problem, which (these eq.) depend on the state vaector.
  Functions.KP07.KPmethod kP(N = N, U = U, dx = dx, theta = theta, B = B, S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = [p_1, m_dot_R; p_2, m_dot_V], boundaryCon = [true, true; false, true]);
  // specify all variables which is needed for using KP method for solve PDE
  BasicEquation basicMid(N = N, U = transpose([U_[1:2:8, :], U_[2:2:8, :]]), rho_atm = Const.rho, A_atm = A_atm * ones(N, 4), beta_total = Const.beta_total, beta = Const.beta, p_a = Const.p_a);
  // Use the model for main equations, but not with state vector, but with the piecewise linear reconstruction of it.
initial equation
  m_dot = Const.rho * V_dot0 * ones(N, 1);
  p_p = [p_1 + dp / 2:dp:p_1 + dp / 2 + dp * (N - 1)];
equation
  /////  define state vector
  U[1:N, 1] = p_p[:, 1];
  U[N + 1:2 * N, 1] = m_dot[:, 1];
  // Define variables interested vol. flow rate
  V_dot = basic.V_dot;
  ////// Define the piecewise linear reconstruction of states.
  U_ = kP.U_;
  //////
  p_ = transpose(matrix(U_[1:2:8, :]));
  ///// mass flow rate
  m_dot_ = transpose(matrix(U_[2:2:8, :]));
  ///// eigenvalues
  lam1 = (basicMid.v + sqrt(basicMid.v .* basicMid.v + 4 * basicMid.A / Const.rho ./ A_atm / Const.beta_total)) / 2;
  lam2 = (basicMid.v - sqrt(basicMid.v .* basicMid.v + 4 * basicMid.A / Const.rho ./ A_atm / Const.beta_total)) / 2;
  ///// F vector
  F_ = [m_dot_ ./ Const.rho ./ A_atm ./ Const.beta_total; m_dot_ .* basicMid.v + basicMid.A .* p_];
  //// source term of friction and gravity forces
  for i in 1:N loop
    F_d[i, 1] = DarcyFriction.Friction(basic.v[i, 1], 2 * sqrt(basic.A[i, 1] / pi), dx, basic.rho[i, 1], Const.mu, Const.eps) / dx;
  end for;
  S_[1:N, 1] = vector(zeros(N, 1));
  S_[N + 1:2 * N, 1] = vector(basic.F_ap * Const.g * H / L - F_d);
  // define defferential equation
  der(U) = kP.diff_eq;
  annotation (
    experiment(StopTime = 100),
    Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for penstock with compressible water and elastic walls is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term S and vector F are implemented in additional function <code>BasicEquation</code> which used one time for centered values and then for boundary values.</p>
</html>"));
end ElasticPenstock;
