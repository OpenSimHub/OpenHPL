within OpenHPL.Tests;
model HPModelLin
  parameter Integer n = 5;
  // states
  parameter Integer k = 1;
  // top-level inputs
  parameter Integer l = 1;
  // top-level outputs
  parameter Real x0[5] = {19.07770613835895, 3647704893.790293, -1.382604290163798e-012, 738276.1017810429, 262866589.5593565};
  parameter Real u0 = 0.7493;
  parameter Real A[5, 5] = [-4.369275046060409, 2.86762571735772e-011, -0.0003348869487959686, 7.712465197971124e-006, -1.525905087339035e-009; 0, 0, 0, 0, 0; 4.213269644367345, 3.434623621803183e-010, -0.004013447140924721, -1.103427849131888e-005, 1.472936995891803e-009; 0, 0, 997, 0, 0; 0, 0, 0, 0, 0];
  parameter Real B[5, 1] = [110.454438012516; 0; -106.6202802906867; 0; 0];
  parameter Real C[1, 5] = [1, 0, 0, 0, 0];
  parameter Real D[1, 1] = [0];
  Real A_[3, 3], B_[3, 1], x_[3, 1](start = [x0[1]; x0[3]; x0[4]]);
  Real x[5](start = x0);
  input Real u(start = u0);
  output Real y[1];
equation
  der(x) = A * x + B * u * ones(1);
  A_ = [A[1, 1], A[1, 3], A[1, 4]; A[3, 1], A[3, 3], A[3, 4]; A[4, 1], A[4, 3], A[4, 4]];
  B_ = [B[1, 1]; B[3, 1]; B[4, 1]];
  der(x_) = A_ * x_ + B_ * u;
  y = C * x + D * u * ones(1);
end HPModelLin;
