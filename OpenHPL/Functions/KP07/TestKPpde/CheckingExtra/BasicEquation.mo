within OpenHPL.Functions.KP07.TestKPpde.CheckingExtra;
model BasicEquation
  extends Icons.Method;
  parameter Integer N "Number of segments";
  input Real U[2 * N, :] "State vector", rho_atm "Atm. density", A_atm[N, :] "Atm. cross area", beta_total "Total compress.", beta "Compress.", p_a "Atm. pressure";
  output Real v[N, scalar(size(U[1, :]))] "Velocity", rho[N, scalar(size(U[1, :]))] "Density", A[N, scalar(size(U[1, :]))] "Cross area", Vdot[N, scalar(size(U[1, :]))] "Vol. flow", F_ap[N, scalar(size(U[1, :]))] "Rho*A";
protected
  Real p_p[N, scalar(size(U[1, :]))] "State, pressure", mdot[N, scalar(size(U[1, :]))] "State, mass flow";
equation
  // decompose state vector
  U[1:N, :] = p_p;
  U[N + 1:2 * N, :] = mdot;
  // define needed variables
  F_ap = rho_atm * A_atm .* (ones(N, scalar(size(p_p[1, :]))) + beta_total * (p_p - p_a * ones(N, scalar(size(p_p[1, :])))));
  v = mdot ./ F_ap;
  rho = rho_atm * (ones(N, scalar(size(p_p[1, :]))) + beta * (p_p - p_a * ones(N, scalar(size(p_p[1, :])))));
  A = F_ap ./ rho;
  Vdot = mdot ./ rho;
end BasicEquation;
