within OpenHPL.Examples;
model DetailedGen "Hydropower system using KP scheme based penstock with generator"
  extends SimpleGen(redeclare Waterway.PenstockKP penstock, data(SteadyState=false));
  annotation (experiment(StopTime=1000));
end DetailedGen;
