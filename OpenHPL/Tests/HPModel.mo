within OpenHPL.Tests;
model HPModel
  inner OpenHPL.Constants Const;
  import Modelica.Constants.pi;
  parameter Real H_r = 48, H_i = 23, H_p = 428.5, H_s = 120, H_d = 0.5, H_t = 5;
  parameter Real L_i = 6600, L_p = 600, L_s = 140, L_d = 600;
  parameter Real D_i = 5.8, D_p = 3, D_s = 3.4, D_d = 5.8;
  parameter Real C_v = 3.7, fD = 0.043;
  parameter Real h_s0 = 69.6998, Vdot_s0 = 0.0, Vdot_p0 = 19.0768;
  input Real u(start = 0.7493);
  Real A_i = D_i ^ 2 * pi / 4, A_p = D_p ^ 2 * pi / 4, A_s = D_s ^ 2 * pi / 4, A_d = D_d ^ 2 * pi / 4;
  Real cos_theta_i = H_i / L_i, cos_theta_p = H_p / L_p, cos_theta_s = H_s / L_s, cos_theta_d = H_d / L_d;
  Real p_r = Const.p_a + Const.g * Const.rho * H_r, p_t = Const.p_a + Const.g * Const.rho * H_t;
  Real Z_i = A_i / L_i, Z_p = A_p / L_p, Z_s = A_s / l_s, Z_d = A_d / L_d;
  Real B_i = D_i / A_i ^ 2, B_p = D_p / A_p ^ 2, B_s = D_s / A_s ^ 2, B_d = D_d / A_d ^ 2;
  Real fD_i = fD, fD_p = fD, fD_s = fD, fD_d = fD;
  Real p_tr1, p_n, K_dp, K_p, K_z, K_pd, K_pdz;
  Real h_s, Vdot_s, Vdot_p, Vdot_i = Vdot_s + Vdot_p, l_s = h_s / cos_theta_s;
initial equation
  h_s = h_s0;
  Vdot_s = Vdot_s0;
  Vdot_p = Vdot_p0;
equation
  K_dp = Z_d / (Z_d + Z_p);
  K_z = K_dp / Z_d;
  K_p = Z_i * Z_d / (Z_i * Z_d + Z_s * Z_d + Z_p * Z_d - Z_p ^ 2 * K_dp);
  K_pd = Z_p * K_dp / Z_d;
  K_pdz = Z_p * K_dp;
  p_n = K_p / Z_i * (Z_i * p_r + Z_s * Const.p_a + Z_p * K_dp * (Vdot_p ^ 2 * Const.p_a / (C_v ^ 2 * u ^ 2) + p_t) + Const.rho * Const.g * (A_p * cos_theta_p * (K_pd - 1) - K_pd * A_d * cos_theta_d + A_s * cos_theta_s + A_i * cos_theta_i) + 1 / 8 * pi * Const.rho * (fD_s * B_s * Vdot_s * abs(Vdot_s) + (fD_d * B_d * K_pd + fD_p * B_p * (1 - K_pd)) * Vdot_p * abs(Vdot_p) - fD_i * B_i * Vdot_i * abs(Vdot_i)));
  p_tr1 = K_z * (Z_p * p_n + Z_d * (Vdot_p ^ 2 * Const.p_a / (C_v ^ 2 * u ^ 2) + p_t) + Const.rho * Const.g * (A_p * cos_theta_p - A_d * cos_theta_d) + 1 / 8 * pi * Const.rho * Vdot_p * abs(Vdot_p) * (fD_d * B_d - fD_p * B_p));
  der(h_s) = Vdot_s * cos_theta_s / A_s;
  der(Vdot_s) = Z_s / Const.rho * (p_n - Const.p_a) - A_s * Const.g * cos_theta_s - 1 / 8 * pi * fD_s * B_s * Vdot_s * abs(Vdot_s);
  der(Vdot_p) = Z_p / Const.rho * (p_n - p_tr1) + A_p * Const.g * cos_theta_p - 1 / 8 * pi * fD_p * B_p * Vdot_p * abs(Vdot_p);
end HPModel;
