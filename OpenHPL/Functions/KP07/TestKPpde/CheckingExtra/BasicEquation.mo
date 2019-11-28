within OpenHPL.Functions.KP07.TestKPpde.CheckingExtra;
model BasicEquation
  extends Icons.Method;
  parameter Integer N "number of segments";
  input Real U[2 * N, :] "state vector", rho_atm "atm. density", A_atm[N, :] "atm. cross area", beta_total "total compress.", beta "compress.", p_a "atm. pressure";
  output Real v[N, scalar(size(U[1, :]))] "velocity", rho[N, scalar(size(U[1, :]))] "density", A[N, scalar(size(U[1, :]))] "cross area", Vdot[N, scalar(size(U[1, :]))] "vol. flow", F_ap[N, scalar(size(U[1, :]))] "rho*A";
protected
  Real p_p[N, scalar(size(U[1, :]))] "state, pressure", mdot[N, scalar(size(U[1, :]))] "state, mass flow";
equation
  //// decompose state vector
  U[1:N, :] = p_p;
  U[N + 1:2 * N, :] = mdot;
  //// define needed variables
  F_ap = rho_atm * A_atm .* (ones(N, scalar(size(p_p[1, :]))) + beta_total * (p_p - p_a * ones(N, scalar(size(p_p[1, :])))));
  v = mdot ./ F_ap;
  rho = rho_atm * (ones(N, scalar(size(p_p[1, :]))) + beta * (p_p - p_a * ones(N, scalar(size(p_p[1, :])))));
  A = F_ap ./ rho;
  Vdot = mdot ./ rho;
end BasicEquation;
