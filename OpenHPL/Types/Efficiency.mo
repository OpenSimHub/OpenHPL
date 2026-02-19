within OpenHPL.Types;
record Efficiency "Example record for efficiency curve"
  extends Modelica.Icons.Record;
  parameter SI.PerUnit EffTable[:,:] =
   [0.0, 0.1;
    0.2, 0.7;
    0.5, 0.9;
   0.95, 0.95;
    1.0, 0.93]
   "Opening of the nozzle or guide vane vs efficieny (can be hydraulic or overall depending on application).";
end Efficiency;
