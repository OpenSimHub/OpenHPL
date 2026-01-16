within OpenHPL.Examples;
model DetailedTurbine "Hydropower system using KP scheme based penstock"
  extends SimpleTurbine(
                 redeclare Waterway.PenstockKP penstock);
  annotation (experiment(StopTime=1000));
end DetailedTurbine;
