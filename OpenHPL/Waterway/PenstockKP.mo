within OpenHPL.Waterway;
model PenstockKP "Detailed model of the pipe. Could have elastic walls and compressible water. KP scheme"
  outer OpenHPL.Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe(    vertical=true);
  import Modelica.Constants.pi;
  //// geometrical parameters of the pipe
  parameter SI.Height H = 420 "Height difference from the inlet to the outlet of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 600 "length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 3.3 "Diametr from the inlet side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diametr from the outlet side of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Height p_eps = data.p_eps "Pipe roughness height" annotation (
    Dialog(group = "Geometry"));
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "if true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// staedy state values for flow rate in all segments of the pipe
  parameter SI.VolumeFlowRate Vdot_0[N] = data.V_0 * ones(N) "Initial flow rate in the pipe vector, m3/s" annotation (
    Dialog(group = "Initialization"));
  //// staedy state values for pressure in all segments of the pipe
  parameter SI.Height h_s0 = 69 "Initial water head before the pipe, m" annotation (
    Dialog(group = "Initialization"));
  parameter SI.Pressure p_p0[N]=  1.013e5 + 997 * 9.81 * (h_s0 + H / N / 2):997 * 9.81 * H / N:1.013e5 + 997 * 9.81 * (h_s0 + H / N * (N - 1 / 2)) "Initial presure vector, bar" annotation (
    Dialog(group = "Initialization"));
  //// segmentation of the pipe
  parameter Integer N = 10 "Number of segments" annotation (
    Dialog(group = "Discretization"));
  //// condition for elasticity
  parameter Boolean PipeElasticity = true "if checked - include pipe elasticity to the model" annotation (
    choices(checkBox = true),
    Dialog(group = "Properties"));
  //// variables
  SI.Diameter dD = (D_i - D_o) / N "step in diameter change", D[N] = linspace(D_i + dD / 2, D_o - dD / 2, N) "centered diameter vector in atm. p.", D_[N + 1] = linspace(D_i, D_o, N + 1) "boundary diameter vector in atm. p.";
  SI.Area A_atm[N] = D .* D * pi / 4 "centered cross are vector in atm. p.", A_atm_[N + 1] = D_ .* D_ * pi / 4 "boundary cross are vector in atm. p.", A[N] "centered cross are vector", A_[N, 4] "boundary cross are vector", _A_atm[N, 4] "boundary cross are matrix in atm. p.";
  SI.Pressure p_p[N] "centered pressure", dp = data.rho * data.g * H / N "initial p. step", p_i "Inlet pressure (LHS)", p_o "Outlet Pressure (RHS)", p_[N, 4] "boundary p. matrix";
  SI.Length dx = L / N "length step", dh = H / N "height step";
  SI.MassFlowRate mdot[N](start = data.rho * Vdot_0) "centered mass flow", mdot_R "left bound mdot", mdot_V "right bound mdot", mdot_[N, 4] "boundary mdot matrix";
  Real U[2 * N] "centered states", U_[8, N] "boundary states", F_ap[N] "centered A*rho", F_ap_[N, 4] "bounddary A*rho", S_[2 * N] "source term", F_[2 * N, 4] "F matrix", lam1[N, 4] "eigenvalue '+'", lam2[N, 4] "eigenvalue '-'";
  SI.Density rho[N] "centered density", rho_[N, 4] "boundary density";
  SI.Velocity v_[N, 4] "bounds velocity", v[N] "centered velocity";
  SI.VolumeFlowRate Vdot[N] "centered volumetric flow";
  SI.Force F_f[N] "centered friction force vector";
  Real theta = 1.3 "parameter for slope limiter";
  extends OpenHPL.Interfaces.TwoContact;
public
  Functions.KP07.KPmethod KP(N = N, U = U, dx = dx, theta = theta, B = zeros(N + 4), S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = [p_i, 0; p_o, 0], boundaryCon = [true, false; true, false]);
  // specify all variables which is needed for using KP method for solve PDE
initial equation
  if SteadyState then
    der(U[1:N]) = zeros(N);
    der(U[N + 2:2 * N - 1]) = zeros(N - 2);
  else
    mdot[2:N - 1] = data.rho * Vdot_0[2:N - 1];
    p_p = p_p0;
  end if;
equation
  //// Pipe flow rate
  mdot_R = i.mdot;
  mdot_V = -o.mdot;
  //// pipe presurre
  p_i = i.p;
  p_o = o.p;
  //// state vector
  U[1:N] = p_p[:];
  U[N + 1:2 * N] = mdot[:];
  //// Define variables, which are going to be used for source term S_
  if PipeElasticity then
    F_ap = data.rho * A_atm .* (ones(N) + data.beta_total * (p_p - data.p_a * ones(N)));
  else
    F_ap = data.rho * A_atm .* (ones(N) + data.beta * (p_p - data.p_a * ones(N)));
  end if;
  v = mdot ./ F_ap;
  rho = data.rho * (ones(N) + data.beta * (p_p - data.p_a * ones(N)));
  A = F_ap ./ rho;
  Vdot = mdot ./ rho;
  //// piece wise linear reconstruction of vector U
  U_ = KP.U_;
  U_[6, 1] = mdot_R;
  U_[4, N] = mdot_V;
  //// presure states
  p_ = transpose(matrix(U_[1:2:8, :]));
  //// mass flow rate states
  mdot_ = transpose(matrix(U_[2:2:8, :]));
  //// define variables, which are going to be used for F matrix and eigenvalues
  _A_atm = [A_atm_[2:N + 1], A_atm_[2:N + 1], A_atm_[1:N], A_atm_[1:N]];
  rho_ = data.rho * (ones(N, 4) + data.beta * (p_ - data.p_a * ones(N, 4)));
  if PipeElasticity then
    F_ap_ = data.rho * _A_atm .* (ones(N, 4) + data.beta_total * (p_ - data.p_a * ones(N, 4)));
  else
    F_ap_ = data.rho * _A_atm .* (ones(N, 4) + data.beta * (p_ - data.p_a * ones(N, 4)));
  end if;
  A_ = F_ap_ ./ rho_;
  v_ = mdot_ ./ F_ap_;
  //// eigenvalues
  if PipeElasticity then
    lam1 = (v_ + sqrt(v_ .* v_ + 4 * A_ / data.rho ./ _A_atm / data.beta_total)) / 2;
    lam2 = (v_ - sqrt(v_ .* v_ + 4 * A_ / data.rho ./ _A_atm / data.beta_total)) / 2;
  else
    lam1 = (v_ + sqrt(v_ .* v_ + 4 * A_ / data.rho ./ _A_atm / data.beta)) / 2;
    lam2 = (v_ - sqrt(v_ .* v_ + 4 * A_ / data.rho ./ _A_atm / data.beta)) / 2;
  end if;
  //// F vector
  if PipeElasticity then
    F_ = [mdot_ ./ data.rho ./ _A_atm ./ data.beta_total; mdot_ .* v_ + A_ .* p_];
  else
    F_ = [mdot_ ./ data.rho ./ _A_atm ./ data.beta; mdot_ .* v_ + A_ .* p_];
  end if;
  //// define friction force in each segment using Darcy friction factor
  for i in 1:N loop
    F_f[i] = Functions.DarcyFriction.Friction(v[i], 2 * sqrt(A[i] / pi), dx, rho[i], data.mu, p_eps);
  end for;
  //// source term of friction and gravity forces
  S_[1:N] = zeros(N);
  S_[N + 1:2 * N] = F_ap * data.g * H / L - F_f / dx;
  //// diff. equation
  der(U) = KP.diff_eq;
  annotation (
    Documentation(info="<html><p>This is a more detailed model for the pipe that mostly can be 
used for proper modelling of the penstock or other conduits.</p>
<p>The model could include the elastic walls and compressible water 
and use discretization method based on Kurganov-Petrova central upwind scheme (KP). 
The geometry of the penstock is described due to figure:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/penstock.svg\" style=\"width:50%\"></p>
<p>Conservation laws are usually solved by Finite-volume methods. 
With the Finite volume method, we divide the grid into small control 
volumes or control cells and then apply the conservation laws. 
Here the pipe is divided in <code>N</code> segments, with input and 
output pressure as a boundary conditions. 
The given cell is denoted by <code>j</code>, i.e., it is the <code>j</code><sup>th</sup> cell. 
Cell average is calculated at the center of the cell and <code>U</code> denotes the 
average values of the conserved variables. The left and the right interfaces of the 
cell are denoted by <code>j-1/2</code> and <code>j+1/2</code> respectively.
 At each cell interface, the right(+)/left(-) point values are reconstructed. 
The letter <code>a</code>denotes the right and the left sided local speeds of propagation 
at the left/right interface of the cell.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/kp.svg\" style=\"width:50%\"></p>
<p>In order to determine the fluxes at the cell interface <code>H</code> and the 
source term <code>S</code>, the KP scheme is used, which is a second order scheme that is well balanced.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/equations/KPScheme.svg\"></p>
<p>More info about the KP pipe model can be found in can be found in 
<a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>.
</p>
</html>"));
end PenstockKP;
