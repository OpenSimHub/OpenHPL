within OpenHPL.Functions.KP07.TestKPpde.CheckingExtra;
model BasicEquation
  extends Icons.Method;
  parameter Integer N "Number of segments";
  input Real U[2 * N, :] "State vector", rho_atm "Atm. density", A_atm[N, :] "Atm. cross area", beta_total "Total compress.", beta "Compress.", p_a "Atm. pressure";
  output Real v[N, size(U, 2)] "Velocity", rho[N, size(U, 2)] "Density", A[N, size(U, 2)] "Cross area", Vdot[N, size(U, 2)] "Vol. flow", F_ap[N, size(U, 2)] "Rho*A";
protected
  Real p_p[N, size(U, 2)] "State, pressure", mdot[N, size(U, 2)] "State, mass flow";
equation
  // decompose state vector
  U[1:N, :] = p_p;
  U[N + 1:2 * N, :] = mdot;
  // define needed variables
  F_ap = rho_atm * A_atm .* (ones(N, size(U, 2)) + beta_total * (p_p - p_a * ones(N, size(U, 2))));
  v = mdot ./ F_ap;
  rho = rho_atm * (ones(N, size(U, 2)) + beta * (p_p - p_a * ones(N, size(U, 2))));
  A = F_ap ./ rho;
  Vdot = mdot ./ rho;
end BasicEquation;
