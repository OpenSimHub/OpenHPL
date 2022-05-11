within OpenHPL.Functions.KP07.TestKPpde.CheckingExtra;
model ElasticPenstock
  extends Modelica.Icons.Example;
  outer Data data;
  import Modelica.Constants.pi;
  parameter SI.Height H = 420 "Height over which water fall in the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 600 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D = 3.3 "Diameter from the input side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.VolumeFlowRate Vdot_0 = 20 "Initial flow rate in the pipe, m3/s" annotation (
    Dialog(group = "Initialization"));
  parameter Integer N = 20;
  SI.Area A_atm = D ^ 2 * pi / 4;
  SI.Pressure p_p[N], dp = data.rho * data.g * H / N, p_1 = 8e5, p_2 = 48e5, p_[N, 4];
  SI.Length dx = L / N, B[N + 4] = zeros(N + 4);
  SI.MassFlowRate mdot[N], mdot_[N, 4], mdot_R = Vdot_0 * data.rho, mdot_V = Vdot_0 * data.rho;
  Real U_[8, N], S_[2 * N], F_[2 * N, 4], lam1[N, 4], lam2[N, 4];
  SI.VolumeFlowRate Vdot[N];
  Real theta = 1.3;
  Real U[2 * N], F_d[N];
public
  BasicEquation basic(N = N, U = U, rho_atm = data.rho, A_atm = A_atm * ones(N), beta_total = data.beta_total, beta = data.beta, p_a = data.p_a);
  // use this model for define main equations for specific problem, which (these eq.) depend on the state vaector.
  Functions.KP07.KPmethod kP(N = N, U = U, dx = dx, theta = theta, B = B, S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = [p_1, mdot_R; p_2, mdot_V], boundaryCon = [true, true; false, true]);
  // specify all variables which is needed for using KP method for solve PDE
  BasicEquation basicMid(N = N, U = transpose([U_[1:2:8, :], U_[2:2:8, :]]), rho_atm = data.rho, A_atm = A_atm * ones(N, 4), beta_total = data.beta_total, beta = data.beta, p_a = data.p_a);
  // Use the model for main equations, but not with state vector, but with the piecewise linear reconstruction of it.
initial equation
  mdot = data.rho * Vdot_0 * ones(N, 1);
  p_p = [p_1 + dp / 2:dp:p_1 + dp / 2 + dp * (N - 1)];
equation
  //  define state vector
  U[1:N, 1] = p_p[:, 1];
  U[N + 1:2 * N, 1] = mdot[:, 1];
  // Define variables interested vol. flow rate
  Vdot = basic.Vdot;
  // Define the piecewise linear reconstruction of states.
  U_ = kP.U_;
  //
  p_ = transpose(matrix(U_[1:2:8, :]));
  // mass flow rate
  mdot_ = transpose(matrix(U_[2:2:8, :]));
  // eigenvalues
  lam1 = (basicMid.v + sqrt(basicMid.v .* basicMid.v + 4 * basicMid.A / data.rho ./ A_atm / data.beta_total)) / 2;
  lam2 = (basicMid.v - sqrt(basicMid.v .* basicMid.v + 4 * basicMid.A / data.rho ./ A_atm / data.beta_total)) / 2;
  // F vector
  F_ = [mdot_ ./ data.rho ./ A_atm ./ data.beta_total; mdot_ .* basicMid.v + basicMid.A .* p_];
  // source term of friction and gravity forces
  for i in 1:N loop
    F_d[i, 1] = DarcyFriction.Friction(basic.v[i, 1], 2 * sqrt(basic.A[i, 1] / pi), dx, basic.rho[i, 1], data.mu, data.p_eps) / dx;
  end for;
  S_[1:N, 1] = vector(zeros(N, 1));
  S_[N + 1:2 * N, 1] = vector(basic.F_ap * data.g * H / L - F_d);
  // define differential equation
  der(U) = kP.diff_eq;
  annotation (
    experiment(StopTime = 100),
    Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for penstock with compressible water and elastic walls is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term S and vector F are implemented in additional function <code>BasicEquation</code> which used one time for centered values and then for boundary values.</p>
</html>"));
end ElasticPenstock;
