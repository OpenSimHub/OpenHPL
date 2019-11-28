within OpenHPL.Tests;
model HPModelDEA
  inner OpenHPL.Data data;
  import Modelica.Constants.pi;
  parameter Real H_r = 48, H_i = 23, H_p = 428.5, H_s = 120, H_d = 0.5, H_t = 5;
  parameter Real L_i = 6600, L_p = 600, L_s = 140, L_d = 600;
  parameter Real D_i = 5.8, D_p = 3, D_s = 3.4, D_d = 5.8;
  parameter Real C_v = 3.7, fD = 0.043;
  input Real u_v = 0.7493;
  Real A_i = D_i ^ 2 * pi / 4, A_p = D_p ^ 2 * pi / 4, A_s = D_s ^ 2 * pi / 4, A_d = D_d ^ 2 * pi / 4;
  Real cos_theta_i = H_i / L_i, cos_theta_p = H_p / L_p, cos_theta_s = H_s / L_s, cos_theta_d = H_d / L_d;
  Real p_r = data.p_a + data.g * data.rho * H_r, p_t = data.p_a + data.g * data.rho * H_t;
  Real Z_i = A_i / L_i, Z_p = A_p / L_p, Z_s = A_s / l_s, Z_d = A_d / L_d;
  Real B_i = D_i / A_i ^ 2, B_p = D_p / A_p ^ 2, B_s = D_s / A_s ^ 2, B_d = D_d / A_d ^ 2;
  Real fD_i = fD, fD_p = fD, fD_s = fD, fD_d = fD;
  Real p_tr1, p_n, p_tr2;
  Real h_s, Vdot_s, Vdot_p, Vdot_i = Vdot_s + Vdot_p, l_s = h_s / cos_theta_s;
initial equation
  h_s = 69.9;
  Vdot_s = 0;
  Vdot_p = 19.077;
equation
  data.rho * L_i * der(Vdot_i) = A_i * (p_r - p_n) + data.rho * L_i * A_i * data.g * cos_theta_i - 1 / 8 * pi * L_i * fD_i * data.rho * B_i * Vdot_i * abs(Vdot_i);
  data.rho * A_s / cos_theta_s * der(h_s) = data.rho * Vdot_s;
  data.rho / cos_theta_s * der(h_s * Vdot_s) = data.rho * Vdot_s ^ 2 / A_s + A_s * (p_n - data.p_a) - data.rho * A_s * h_s * data.g - 1 / 8 * pi * fD_s * data.rho * l_s * B_s * Vdot_s * abs(Vdot_s);
  data.rho * L_p * der(Vdot_p) = A_p * (p_n - p_tr1) + data.rho * L_p * A_p * data.g * cos_theta_p - 1 / 8 * pi * fD_p * data.rho * L_p * B_p * Vdot_p * abs(Vdot_p);
  Vdot_p = C_v * u_v * sqrt((p_tr1 - p_tr2) / data.p_a);
  //p_tr1 - p_tr2 = Vdot_p^2 * data.p_a/(C_v*u_v)^ 2;
  data.rho * L_d * der(Vdot_p) = A_d * (p_tr2 - p_t) + data.rho * L_d * A_d * data.g * cos_theta_d - 1 / 8 * pi * fD_d * data.rho * L_d * B_d * Vdot_p * abs(Vdot_p);
end HPModelDEA;
