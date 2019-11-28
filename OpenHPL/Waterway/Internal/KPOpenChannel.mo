within OpenHPL.Waterway.Internal;
model KPOpenChannel "Implementation of the KP functions for an open channel"
  outer Data data;
  parameter Integer N = 100;
  parameter Modelica.SIunits.Length w = 194 "Channel width", L = 5000 "Channel length";
  parameter Modelica.SIunits.Height H[2] = {16.7, 0} "Channel height, left and right side", b[N + 1] = linspace(H[1], H[2], N + 1) "Riverbed", h0[N] = vector([ones(5) * 0.4; linspace(H[1] - 0.4 - 0.5 * (b[6] + b[7]), H[1] - 0.4 - 0.5* (b[N] + b[N + 1]), N - 5)]) "Initial depth";
  parameter Modelica.SIunits.VolumeFlowRate V_dot0 = 120 "Initial flow rate";
  parameter Real f_n = 0.04 "Manning's roughness coefficient [s/m^1/3]";
  parameter Boolean boundaryCondition[2, 2] = [false, true; false, true] "boundary conditions considiratiion [z_left, q_left; z_right, q_right]", SteadyState = false "if true - starts from Steady State";
  input Real boundaryValues[2, 2] = [h0[1] + b[1], V_dot0 / w; h0[N] + b[N + 1], V_dot0 / w] "values for the boundary conditions [z_left, q_left; z_right, q_right]";
  Modelica.SIunits.Length dx = L / N;
  Modelica.SIunits.VolumeFlowRate V_dot[N];
  Modelica.SIunits.Height z[N], B[N], z_[N, 4], h_[N, 4], h[N](start = h0);
  Modelica.SIunits.Velocity u_[N, 4];
  Real q0 = V_dot0 / w, q[N](start = ones(N) * V_dot0 / w), q_[N, 4], q_t;
  Real S_[2 * N], theta = 1.3, F_[2 * N, 4], lam1[N, 4], lam2[N, 4], F_f[N];
  Real U[2 * N], U_[8, N], U_mp[N], U_pm[N];
public
  Functions.KP07.KPmethod KP(N = N, U = vector([h; q]), dx = dx, theta = theta, B = vector([b[1] + 3 / 2 * (b[1] - b[2]); b[1] + 1 / 2 * (b[1] - b[2]); B; b[N + 1] - 1 / 2 * (b[N] - b[N+1]); b[N + 1] - 3 / 2 * (b[N] - b[N+1])]), S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = boundaryValues, boundaryCon = boundaryCondition);
  // specify all variables which is needed for using KP method for solve PDE
initial equation
  if SteadyState == true then
    der(U) = zeros(2 * N);
  else
    q = ones(N) * q0;
    h = h0;
  end if;
equation
  /// disturbance
  if time < 1200 then
    q_t = q0;
  elseif time < 1300 then
    q_t = q0 + 10 / w;
  else
    q_t = q0;
  end if;
  //boundaryValues = [h0[1] + b[1], q_t; h0[N] + b[N + 1], q0];
  /// centered riverbed
  B = (b[1:N] + b[2:N + 1]) / 2;
  /// z vector
  z = h + B;
  /// q vector
  q = V_dot / w;
  /// U vector
  U = vector([z; q]);
  /// piece wise linear reconstruction of vector U
  U_ = KP.U_;
  /// positivity preserving
  for i in 1:N loop
    if U_[1, i] < b[i + 1] then
      U_mp[i] = h[i] + b[i + 1];
    else
      U_mp[i] = U_[1, i];
    end if;
    if U_[7, i] < b[i] then
      U_pm[i] = h[i] + b[i];
    else
      U_pm[i] = U_[7, i];
    end if;
  end for;
  /// decompose states
  z_ = [U_mp, transpose(matrix(U_[3:2:5, :])), U_pm];
  h_ = z_ - [b[2:N + 1], b[2:N + 1], b[1:N], b[1:N]];
  q_ = transpose(matrix(U_[2:2:8, :]));
  /// desingularization
  for i in 1:N loop
    u_[i, 1] = 2 * h_[i, 1] * q_[i, 1] / (h_[i, 1] ^ 2 + max(h_[i, 1] ^ 2, 1e-10));
    u_[i, 2] = 2 * h_[i, 2] * q_[i, 2] / (h_[i, 2] ^ 2 + max(h_[i, 2] ^ 2, 1e-10));
    u_[i, 3] = 2 * h_[i, 3] * q_[i, 3] / (h_[i, 3] ^ 2 + max(h_[i, 3] ^ 2, 1e-10));
    u_[i, 4] = 2 * h_[i, 4] * q_[i, 4] / (h_[i, 4] ^ 2 + max(h_[i, 4] ^ 2, 1e-10));
  end for;
  /// eigenvalues
  lam1 = u_ + sqrt(h_ * data.g);
  lam2 = u_ - sqrt(h_ * data.g);
  /// F vector
  F_ = [q_; q_ .* q_ ./ h_ + data.g * h_ .* h_ / 2];
  /// source term of friction and gravity forces
  for i in 1:N loop
    F_f[i] = (-data.g * h[i] * (b[i + 1] - b[i]) / dx) - f_n ^ 2 * data.g * q[i] * abs(q[i]) * (w + 2 * h[i] ^ (4 / 3)) / w ^ (4 / 3) * (2 * h[i] / (h[i] ^ 2 + max(h_[i, 4] ^ 2, 1e-10))) ^ (7 / 3);
  end for;
  S_[1:N] = zeros(N);
  S_[N + 1:2 * N] = F_f;
  /// diff. equation
  der(U) = KP.diff_eq;
  annotation (
    experiment(StopTime = 5000),
    Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for openchannel is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term S and vector F are implemented inside this model.</p>
</html>"));
end KPOpenChannel;
