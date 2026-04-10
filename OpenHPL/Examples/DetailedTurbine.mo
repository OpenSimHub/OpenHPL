within OpenHPL.Examples;
model DetailedTurbine "Hydropower system using KP scheme based penstock"
  extends SimpleTurbine(
                 redeclare Waterway.PenstockKP penstock);
  annotation (experiment(StopTime = 1000, StartTime = 0, Tolerance = 1e-06, Interval = 2));
end DetailedTurbine;