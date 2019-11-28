within OpenHPL.Tests;
model HPModelLinPI
  HPModelLin hplin;
  HPLiniarization hp;
  parameter Real Kp = 0.3;
  parameter Real Ki = 1.5;
  parameter Real ref0 = 19.0777;
  Real err, err1, u(start = 0.7493, fixed = true), u1(start = 0.7493, fixed = true), xi, xi1;
  input Real ref(start = ref0);
  output Real dotVp1, dotVs1, dotVp2, dotVs2;
  output Real ms1, ms2;
equation
  hplin.u = u;
  hp.u = u1;
  err = ref - hplin.y[1];
  err1 = ref - hp.dotV;
  der(xi) = Ki * err;
  der(xi1) = Ki * err1;
  u = Kp * err + xi;
  u1 = min(1.0, Kp * err1 + xi1);
  dotVp1 = hplin.y[1];
  dotVs1 = hplin.x[3];
  ms1 = hplin.x[4];
  dotVp2 = hp.dotV;
  dotVs2 = hp.surgeTank.Vdot;
  ms2 = hp.surgeTank.m;
end HPModelLinPI;
