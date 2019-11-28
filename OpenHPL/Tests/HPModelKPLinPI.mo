within OpenHPL.Tests;
model HPModelKPLinPI
  HPLiniarizationKP hpKP;
  parameter Real Kp = 0.1;
  parameter Real Ki = 2.5;
  parameter Real ref0 = 19.0777;
  Real err1, u1(start = 0.7493, fixed = true), xi1;
  input Real ref(start = ref0);
  output Real dotVp2, dotVs2;
  output Real ms2;
equation
  hpKP.u = u1;
  err1 = ref - hpKP.dotV;
  der(xi1) = Ki * err1;
  u1 = min(1.0, Kp * err1 + xi1);
  dotVp2 = hpKP.dotV;
  dotVs2 = hpKP.surgeTank.Vdot;
  ms2 = hpKP.surgeTank.m;
end HPModelKPLinPI;
