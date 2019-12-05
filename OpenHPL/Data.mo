within OpenHPL;
record Data "Provides a data set of most common used settings"
  extends Modelica.Icons.Record;
  parameter Modelica.SIunits.Acceleration g = Modelica.Constants.g_n "Gravity constant"
    annotation (Dialog(enable=false, group = "Constants"));
  parameter Real gamma_air = 1.4 "Specific heat capacity ratio for air"
    annotation (Dialog(enable=false, group = "Constants"));
  parameter Modelica.SIunits.Pressure p_a = 1.013e5 "Atmospheric pressure"
    annotation (Dialog(group = "Constants"));
  parameter Modelica.SIunits.MolarMass M_a = 28.97e-3 "Molar mass of air"
    annotation (Dialog(group = "Constants"));
  parameter Modelica.SIunits.Density rho = 999.65 "Water density at T_0"
    annotation (Dialog(group = "Waterway properties"));
  parameter Modelica.SIunits.DynamicViscosity mu = 1.3076e-3 "Dynamic viscosity of water at T_0"
    annotation (Dialog(group = "Waterway properties"));
  parameter Modelica.SIunits.Height p_eps = 5e-2 "Pipe roughness height"
    annotation (Dialog(group = "Waterway properties"));
  parameter Modelica.SIunits.Compressibility beta = 4.5e-10 "Water compressibility"
    annotation (Dialog(group = "Waterway properties"));
  parameter Modelica.SIunits.Compressibility beta_total = 1 / (rho*1000^2) "Total compressibility"
   annotation (Dialog(group = "Waterway properties"));
  parameter Boolean TempUse = false "If checked, the water temperature is not constant"
    annotation (choices(checkBox = true), Dialog(group = "Thermal behaviour (not yet implemented)"));
  parameter Modelica.SIunits.Temperature T_0(displayUnit="degC") = 283.15 "Initial water temperature"
    annotation (Dialog(group = "Thermal behaviour (not yet implemented)", enable = TempUse));
  parameter Modelica.SIunits.SpecificHeatCapacity c_p = 4200 "Heat capacity of water at T_0"
    annotation (Dialog(group = "Thermal behaviour (not yet implemented)", enable = TempUse));
  parameter Boolean Steady = false "If checked, simulation starts from Steady State"
    annotation (choices(checkBox = true), Dialog(group = "Initialization"));
  parameter Modelica.SIunits.VolumeFlowRate V_0 = 19.077 "Initial flow rate through the system"
    annotation (Dialog(group = "Initialization"));
  parameter Modelica.SIunits.Frequency f_0 = 50 "Initial system frequency"
    annotation (Dialog(group = "Initialization"));
  annotation (
    Documentation(info = "<html><p>Here a common data set for this library is defined. </p>
    <p>It is possible to insert this class to models and use the common data set for the respective model.</p>
    </html>"),
    defaultComponentName = "data",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "No 'data' component is defined. A default component will be used and provide system parameters");
end Data;
