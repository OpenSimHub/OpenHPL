within OpenHPL.Functions;

function TurbineLookUp
  extends Modelica.Icons.Function;
  //
  input SI.Length Ht;
  input SI.Frequency nrps;
  input Real opening;
  input OpenHPL.Types.TurbineData td "Turbine data";
  input OpenHPL.Types.HillChart hc "Hill chart";
  output SI.VolumeFlowRate Qt "Discharge";
  output SI.Torque Tt "Hydraulic torque";
protected
  constant Real phi = (1 + sqrt(5))/2 "Golden ratio";
  constant Real resphi = 2 - phi "Reciprocal of golden ratio (0.618...)";
  constant Real eps = 1.0e-08;
  constant Integer nitr = 99;
  Real a "Current left bound";
  Real b "Current right bound";
  Real t1 "First interior point";
  Real t2 "Second interior point";
  Real f1 "Function value at x1";
  Real f2 "Function value at x2";
  Real x_min "Current estimate of minimum location";
  Real f_min "Current estimate of minimum value";
  Real controlPoints[hc.nPoints, hc.nDim];
  Real[hc.nDim] cP1;
  Real[hc.nDim] cP2;
  Real target;
  Real err;
  Integer itr;
algorithm
  controlPoints:=WeightedControlPoints(opening,hc);
  target:=((nrps*td.Dn)/sqrt(Ht*td.g))/((td.nrps*td.Dn)/sqrt(td.Hbep*td.g));
  a:=0;
  b:=1;
  itr:=0;
  err:=1.e+10;
  t1 := a + resphi*(b - a);
  cP1 := deCasteljau(t1, hc.nDim, controlPoints);
  f1 := sqrt((cP1[1] - target)^2);
  t2 := b - resphi*(b - a);
  cP2 := deCasteljau(t2, hc.nDim, controlPoints);
  f2 := sqrt((cP2[1] - target)^2);
  while ((err > eps) and (itr < nitr)) loop
    if f1 < f2 then
// Minimum is in [a, x2]
      b := t2;
      t2 := t1;
      f2 := f1;
      t1 := a + resphi*(b - a);
      cP1 :=deCasteljau(t1, hc.nDim, controlPoints);
      f1 := sqrt((cP1[1] - target)^2);
    else
// Minimum is in [x1, b]
      a := t1;
      t1 := t2;
      f1 := f2;
      t2 := b - resphi*(b - a);
      cP2 := deCasteljau(t2, hc.nDim, controlPoints);
      f2 := sqrt((cP2[1] - target)^2);
    end if;
    itr := itr + 1;
    err := min(f1, f2);
  end while;
  Qt := (cP1[2] + cP2[2])*0.5*(td.Qbep*sqrt(Ht/td.Hbep));
  Tt := (cP1[3] + cP2[3])*0.5*(td.Tbep*(Ht/td.Hbep));

annotation(
    Documentation(info = "<html><head></head><body>
<p>Compute the physical discharge and torque based on the speed [nrps] head [Ht] and opening. The algorithm is briely summarized below. 
<ol>
<li>Find the actual charateristic curve by weighted interpolation of the two closest curves</li>
<li>Use golden section search to find the correct position along the speed curve</li>
<li>Compute physcal discharge and torqu based on normalized unit data and the turbine information</li>
</ol></p></body></html>"));


end TurbineLookUp;
