within OpenHPL.Functions.KP07.KPfunctions;
model SpeedPropagationApipe
  extends Icons.Method;
  parameter Integer N "number of segments";
  input Real lamda1[N, 4], lamda2[N, 4];
  output Real A[N, 4];
protected
  Real a_mp[N], a_mm[N], a_pm[N], a_pp[N];
equation
  for i in 1:N loop
    a_mp[i] = min(min(lamda2[i, 2], lamda2[i, 1]), 0);
    a_pp[i] = max(max(lamda1[i, 2], lamda1[i, 1]), 0);
    a_mm[i] = min(min(lamda2[i, 4], lamda2[i, 3]), 0);
    a_pm[i] = max(max(lamda1[i, 4], lamda1[i, 3]), 0);
  end for;
  A = [a_mp, a_pp, a_mm, a_pm];
  annotation (
    Documentation(info = "<html>
<p>The mode lfor defining the the one-sided local speed of propagations. Estimated as the largest and the smallest eigen values of the Jacobian of the system.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/eq_speed_propag.png\"/></p>
</html>"));
end SpeedPropagationApipe;
