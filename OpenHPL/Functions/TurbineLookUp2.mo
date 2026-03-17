within OpenHPL.Functions;

function TurbineLookUp2
extends Modelica.Icons.Function;
  //
  input SI.Length Ht;
  input SI.Frequency nrps;
  input Real opening;
  input OpenHPL.Types.TurbineData td "Turbine data";
  input OpenHPL.Types.TurbineCharacteristics hc "Turbine characteristics";
  output SI.VolumeFlowRate Qt "Discharge";
  output SI.Torque Tt "Hydraulic torque";
protected
  constant Real eps = 1.0e-08;
  Real controlPoints[hc.nPoints, hc.nDim];
  Real[hc.nDim] cP;
  Real t;
  Integer itr;
algorithm
  controlPoints:=WeightedControlPoints(opening,hc);
  // Added the: max(abs(Ht),eps) due to errors when initializing the model.
  t:=((nrps*td.Dn)/sqrt(max(abs(Ht),eps)*td.g))/((td.nrps*td.Dn)/sqrt(td.Hbep*td.g))*(1/(2*sqrt(2)));
  cP := deCasteljau(t, hc.nDim, controlPoints);
  Qt := cP[2]*(td.Qbep*sqrt(Ht/td.Hbep));
  Tt := cP[3]*(td.Tbep*(Ht/td.Hbep));

end TurbineLookUp2;
