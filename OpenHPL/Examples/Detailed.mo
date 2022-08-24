within OpenHPL.Examples;
model Detailed "Hydropower system using KP scheme based penstock"
  extends Simple(redeclare Waterway.PenstockKP penstock);
  annotation (experiment(StopTime=1000));
end Detailed;
