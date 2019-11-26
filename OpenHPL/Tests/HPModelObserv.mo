within OpenHPL.Tests;
model HPModelObserv
  inner OpenHPL.Data data;
  import Modelica.Constants.pi;
  parameter Real H_r = 48, H_i = 23, H_p = 428.5, H_s = 120, H_d = 0.5, H_t = 5;
  parameter Real L_i = 6600, L_p = 600, L_s = 140, L_d = 600;
  parameter Real D_i = 5.8, D_p = 3, D_s = 3.4, D_d = 5.8;
  parameter Real C_v = 3.7, fD = 0.043;
  parameter Real L3 = -10;
  parameter Real L1 = 5;
  parameter Real z_2 = -670;
  parameter Real L1uweight = 0;
  input Real u;
  input Real x1, x3;
  Real A_i = D_i ^ 2 * pi / 4, A_p = D_p ^ 2 * pi / 4, A_s = D_s ^ 2 * pi / 4, A_d = D_d ^ 2 * pi / 4;
  Real cos_theta_i = H_i / L_i, cos_theta_p = H_p / L_p, cos_theta_s = H_s / L_s, cos_theta_d = H_d / L_d;
  Real p_r = para.p_a + para.g * para.rho * H_r, p_t = para.p_a + para.g * para.rho * H_t;
  Real Z_i = A_i / L_i, Z_p = A_p / L_p, Z_s = A_s * cos_theta_s / x3, Z_d = A_d / L_d;
  Real B_i = D_i / A_i ^ 2, B_p = D_p / A_p ^ 2, B_s = D_s / A_s ^ 2, B_d = D_d / A_d ^ 2;
  Real fD_i = fD, fD_p = fD, fD_s = fD, fD_d = fD;
  Real phat_tr1, phat_n, K_dp, K_p, K_z, K_pd;
  Real xhat_2, zhat_2;
  Real L1u, L1l, L11;
initial equation
  zhat_2 = z_2;
equation
  K_dp = Z_d / (Z_d + Z_p);
  K_z = K_dp / Z_d;
  K_p = Z_i * Z_d / (Z_i * Z_d + Z_s * Z_d + Z_p * Z_d - Z_p ^ 2 * K_dp);
  K_pd = Z_p * K_dp / Z_d;
  xhat_2 = zhat_2 - L11 * x1 - L3 * x3;
  der(zhat_2) = A_s * cos_theta_s / para.rho / x3 * (phat_n - para.p_a) - A_s * para.g * cos_theta_s - 1 / 8 * pi * fD_s * B_s * xhat_2 * abs(xhat_2) + L11 * (Z_p / para.rho * (phat_n - phat_tr1) + A_p * para.g * cos_theta_p - 1 / 8 * pi * fD_p * B_p * x1 * abs(x1)) + L3 * (xhat_2 * cos_theta_s / A_s);
  phat_n = K_p / Z_i * (Z_i * p_r + Z_s * para.p_a + Z_p * K_dp * (x1 ^ 2 * para.p_a / (C_v ^ 2 * u ^ 2) + p_t) + para.rho * para.g * (A_p * cos_theta_p * (K_pd - 1) - K_pd * A_d * cos_theta_d + A_s * cos_theta_s + A_i * cos_theta_i) + 1 / 8 * pi * para.rho * (fD_s * B_s * xhat_2 * abs(xhat_2) + (fD_d * B_d * K_pd + fD_p * B_p * (1 - K_pd)) * x1 * abs(x1) - fD_i * B_i * (x1 + xhat_2) * abs(x1 + xhat_2)));
  phat_tr1 = K_z * (Z_p * phat_n + Z_d * (x1 ^ 2 * para.p_a / (C_v ^ 2 * u ^ 2) + p_t) + para.rho * para.g * (A_p * cos_theta_p - A_d * cos_theta_d) + 1 / 8 * pi * para.rho * x1 * abs(x1) * (fD_d * B_d - fD_p * B_p));
  L1u = A_s * cos_theta_s / x3 / Z_p / (1 - K_z * Z_p);
  L1l = L1u - Z_i / Z_p / K_p / (1 - K_z * Z_p);
  L11 = L1 + L1u * L1uweight;
end HPModelObserv;
