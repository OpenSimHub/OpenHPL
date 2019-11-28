within OpenHPL.Functions.KP07.TestKPpde;
model ElasticPenstock
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  parameter Modelica.SIunits.Height H = 420 "Height over which water fall in the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length L = 600 "length of the pipe, m" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Diameter D = 3.3 "Diametr of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.VolumeFlowRate Vdot_0 = 20 "initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20 "Number of segments";
  Modelica.SIunits.Area A_atm = D ^ 2 * pi / 4 "pipe are at atm. p.", A[N] "center pipe A", A_[N, 4] "bounds pipe A";
  Modelica.SIunits.Pressure p_p[N] "center pressure", dp = data.rho * data.g * H / N "initial p. step", p_1 = 8e5 "input p.", p_2 = 48e5 "output p.", p_[N, 4] "bounds p.";
  Modelica.SIunits.Length dx = L / N "length step", B[N + 4] = zeros(N + 4) "additional for open channel";
  Modelica.SIunits.MassFlowRate mdot[N] "center mass flow", mdot_[N, 4] "bounds mass flow", mdot_R = Vdot_0 * data.rho "input mdot", mdot_V = Vdot_0 * data.rho "output mdot";
  Real F_ap[N] "centered A*rho", S_[2 * N] "source term", F_[2 * N, 4] "F matrix", lam1[N, 4] "eigenvalue '+'", lam2[N, 4] "eigenvalue '-'", F_ap_[N, 4] "bounds A*rho";
  Modelica.SIunits.Density rho[N] "centered density", rho_[N, 4] "bounds density";
  Modelica.SIunits.Velocity v_[N, 4] "bounds velocity", v[N] "centered velocity";
  Modelica.SIunits.VolumeFlowRate Vdot[N] "centered volumetric flow";
  Real theta = 1.3 "parameter for slope limiter";
  Real U_[8, N] "bounds states", U[2 * N] "center states", F_d[N] "friction";
public
  Functions.KP07.KPmethod kP(N = N, U = U, dx = dx, S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = [p_1, mdot_R; p_2, mdot_V], boundaryCon = [true, true; false, true]);
  // specify all variables which is needed for using KP method for solve PDE
  inner Data data annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
initial equation
  mdot = data.rho * Vdot_0 * ones(N);
  p_p = p_1 + dp / 2:dp:p_1 + dp / 2 + dp * (N - 1);
equation
  /////  define state vector
  U[1:N] = p_p[:];
  U[N + 1:2 * N] = mdot[:];
  ///// Define variables, which are going to be used for source term S_
  F_ap = data.rho * A_atm * (ones(N) + data.beta_total * (p_p - data.p_a * ones(N)));
  v = mdot ./ F_ap;
  rho = data.rho * (ones(N) + data.beta * (p_p - data.p_a * ones(N)));
  A = F_ap ./ rho;
  Vdot = mdot ./ rho;
  ///// Define the piecewise linear reconstruction of states.
  U_ = kP.U_;
  ///// decompose matrix U into state matrix
  p_ = transpose(matrix(U_[1:2:8, :]));
  mdot_ = transpose(matrix(U_[2:2:8, :]));
  ///// define variables, which are going to be used for F matrix and eigenvalues
  rho_ = data.rho * (ones(N, 4) + data.beta * (p_ - data.p_a * ones(N, 4)));
  F_ap_ = data.rho * A_atm * (ones(N, 4) + data.beta_total * (p_ - data.p_a * ones(N, 4)));
  A_ = F_ap_ ./ rho_;
  v_ = mdot_ ./ F_ap_;
  ///// define eigenvalues
  lam1 = (v_ + sqrt(v_ .* v_ + 4 * A_ / data.rho ./ A_atm / data.beta_total)) / 2;
  lam2 = (v_ - sqrt(v_ .* v_ + 4 * A_ / data.rho ./ A_atm / data.beta_total)) / 2;
  ///// F vector
  F_ = [mdot_ ./ data.rho ./ A_atm ./ data.beta_total; mdot_ .* v_ + A_ .* p_];
  ///// source term of friction and gravity forces
  for i in 1:N loop
    // define friction force in each segment using Darcy friction factor
    F_d[i] = DarcyFriction.Friction(v[i], 2 * sqrt(A[i] / pi), dx, rho[i], data.mu, data.eps) / dx;
  end for;
  S_[1:N] = vector(zeros(N));
  S_[N + 1:2 * N] = vector(F_ap * data.g * H / L - F_d);
  ///// differential equation
  der(U) = kP.diff_eq;
  annotation (
    experiment(StopTime = 100),
    Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for penstock with compressible water and elastic walls is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term <i>S</i> and vector <i>F</i> are implemented inside this model.</p>
</html>"));
end ElasticPenstock;
