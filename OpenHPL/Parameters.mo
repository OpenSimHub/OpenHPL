within OpenHPL;
record Parameters "Provides a set of base parameters for this library"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Acceleration g = Modelica.Constants.g_n "gravity" annotation (
    Dialog(enable=false, group = "Constants"));
  parameter Modelica.SIunits.Density rho = 997.0 "density" annotation (
    Dialog(group = "Properties"));
  parameter Modelica.SIunits.DynamicViscosity mu = 0.89e-3 "dynamic viscosity of water" annotation (
    Dialog(group = "Properties"));
  parameter Modelica.SIunits.Height eps = 5e-2 "pipe roughness height" annotation (
    Dialog(group = "Properties"));
  parameter Modelica.SIunits.Pressure p_a = 1.013e5 "Atmospheric pressure" annotation (
    Dialog(group = "Constants"));
  parameter Modelica.SIunits.Compressibility beta = 4.5e-10 "water compressibility" annotation (
    Dialog(group = "Properties"));
  parameter Modelica.SIunits.Compressibility beta_total = 1 / rho / 1000 ^ 2 "total compressibility" annotation (
    Dialog(group = "Properties"));
  parameter Boolean Steady = false "If checked - simulation starts from Steady State" annotation (
    choices(checkBox = true),
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.VolumeFlowRate V_0 = 19.077 "Initial flow rate through the system" annotation (
    Dialog(group = "Initialization"));
  //parameter Boolean TempUse = false "If checked - the water temperature is not constant" annotation (choices(checkBox = true), Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_i = 273 + 10 "Initial water temperature" annotation (Dialog(group = "Initialization", enable = TempUse));
  parameter Modelica.SIunits.Frequency f = 50 "Initial frequency" annotation (
    Dialog(group = "Initialization"));
  parameter Modelica.SIunits.SpecificHeatCapacity c_p = 4200 annotation (
    Dialog(group = "Constants"));
  annotation (
    Documentation(info = "<html><head></head><body><p>Here, common parameters&nbsp;are determined for this library. </p><p>It is possible to insert this class to models and use the common parameters for whole library.&nbsp;</p>
  </body></html>"),
    defaultComponentName = "para",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "No 'para' component is defined. A default component will be used and provide system parameters");
end Parameters;
