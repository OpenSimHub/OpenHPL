within OpenHPL.Waterway.Internal;
model KPOpenChannel "Implementation of the KP functions for an open channel"
  outer Data data "Using standard data set";
  parameter Integer N = 100 "Number of segments";
  parameter SI.Length W=194 "Channel width";
  parameter SI.Length L = 5000 "Channel length";
  parameter SI.Height H[2] = {16.7, 0} "Channel height, left and right side", b[N + 1] = linspace(H[1], H[2], N + 1) "Riverbed";
  parameter SI.Height h_0[N]=vector([ones(5)*0.4; linspace(
      H[1] - 0.4 - 0.5*(b[6] + b[7]),
      H[1] - 0.4 - 0.5*(b[N] + b[N + 1]),
      N - 5)]) "Initial depth";
  parameter SI.VolumeFlowRate Vdot_0 = 120 "Initial flow rate";
  parameter Real f_n = 0.04 "Manning's roughness coefficient [s/m^1/3]";
  parameter Boolean boundaryCondition[2, 2] = [false, true; false, true] "Boundary conditions considering [z_left, q_left; z_right, q_right]", SteadyState = false "If true - starts from Steady State";
  input Real boundaryValues[2,2]=[h_0[1] + b[1],Vdot_0/W; h_0[N] + b[N + 1],Vdot_0/W] "Values for the boundary conditions [z_left, q_left; z_right, q_right]";
  SI.Length dx = L / N;
  SI.VolumeFlowRate Vdot[N];
  SI.Height z[N], B[N], z_[N, 4], h_[N, 4], h[N](start=h_0);
  SI.Velocity u_[N, 4];
  Real q0 = Vdot_0 /W, q[N](start = ones(N) * Vdot_0 /W), q_[N, 4], q_t;
  Real S_[2 * N], theta = 1.3, F_[2 * N, 4], lam1[N, 4], lam2[N, 4], F_f[N];
  Real U[2 * N], U_[8, N], U_mp[N], U_pm[N];
  Functions.KP07.KPmethod KP(N = N, U = vector([h; q]), dx = dx, theta = theta, B = vector([b[1] + 3 / 2 * (b[1] - b[2]); b[1] + 1 / 2 * (b[1] - b[2]); B; b[N + 1] - 1 / 2 * (b[N] - b[N+1]); b[N + 1] - 3 / 2 * (b[N] - b[N+1])]), S_ = S_, F_ = F_, lam1 = lam1, lam2 = lam2, boundary = boundaryValues, boundaryCon = boundaryCondition)
  "Specify all variables which is needed for using KP method for solve PDE";
initial equation
  if SteadyState then
    der(U) = zeros(2 * N);
  else
    q = ones(N) * q0;
    h =h_0;
  end if;
equation
  // disturbance
  if time < 1200 then
    q_t = q0;
  elseif time < 1300 then
    q_t = q0 + 10 /W;
  else
    q_t = q0;
  end if;
  // BoundaryValues = [h0[1] + b[1], q_t; h0[N] + b[N + 1], q0];
  // Centered riverbed
  B = (b[1:N] + b[2:N + 1]) / 2;
  // z vector
  z = h + B;
  // q vector
  q = Vdot /W;
  // U vector
  U = vector([z; q]);
  // Piece wise linear reconstruction of vector U
  U_ = KP.U_;
  // Positivity preserving
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
  // Decompose states
  z_ = [U_mp, transpose(matrix(U_[3:2:5, :])), U_pm];
  h_ = z_ - [b[2:N + 1], b[2:N + 1], b[1:N], b[1:N]];
  q_ = transpose(matrix(U_[2:2:8, :]));
  // Desingularization
  for i in 1:N loop
    u_[i, 1] = 2 * h_[i, 1] * q_[i, 1] / (h_[i, 1] ^ 2 + max(h_[i, 1] ^ 2, 1e-10));
    u_[i, 2] = 2 * h_[i, 2] * q_[i, 2] / (h_[i, 2] ^ 2 + max(h_[i, 2] ^ 2, 1e-10));
    u_[i, 3] = 2 * h_[i, 3] * q_[i, 3] / (h_[i, 3] ^ 2 + max(h_[i, 3] ^ 2, 1e-10));
    u_[i, 4] = 2 * h_[i, 4] * q_[i, 4] / (h_[i, 4] ^ 2 + max(h_[i, 4] ^ 2, 1e-10));
  end for;
  // Eigenvalues
  lam1 = u_ + sqrt(h_ * data.g);
  lam2 = u_ - sqrt(h_ * data.g);
  // F vector
  F_ = [q_; q_ .* q_ ./ h_ + data.g * h_ .* h_ / 2];
  // Source term of friction and gravity forces
  for i in 1:N loop
    F_f[i] = (-data.g * h[i] * (b[i + 1] - b[i]) / dx) - f_n ^ 2 * data.g * q[i] * abs(q[i]) * (W + 2 * h[i] ^ (4 / 3)) /W ^ (4 / 3) * (2 * h[i] / (h[i] ^ 2 + max(h_[i, 4] ^ 2, 1e-10))) ^ (7 / 3);
  end for;
  S_[1:N] = zeros(N);
  S_[N + 1:2 * N] = F_f;
  der(U) = KP.diff_eq "Differential equation";
  annotation(Documentation(info = "<html>
<p>Here is example of using the KP function to solve hyperbolic PDE (here, model for openchannel is used).</p>
<p>All calculation of the variables that is used for defining eigenvalues, source term S and vector F are implemented inside this model.</p>
</html>"));
end KPOpenChannel;
