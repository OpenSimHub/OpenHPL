within OpenHPL;
record Data "Provides a data set of most common used settings"
  extends Modelica.Icons.Record;
  parameter SI.Acceleration g = Modelica.Constants.g_n "Gravity constant"
    annotation (Dialog(enable=false, group = "Constants"));
  parameter Real gamma_air = 1.4 "Ratio of heat capacities at constant pressure (C_p) to constant volume (C_v) for air at STP"
    annotation (Dialog(enable=false, group = "Constants"));
  parameter SI.Pressure p_a = 0 "Default calculation is gauge pressure (set p_a to atmospheric pressure if absolute pressure is required)"
    annotation (Dialog(group = "Constants"));
  parameter SI.MolarMass M_a = 28.97e-3 "Molar mass of air at STP"
    annotation (Dialog(group = "Constants"));
  parameter SI.Density rho = 999.65 "Water density at T_0"
    annotation (Dialog(group = "Waterway properties"));
  parameter SI.DynamicViscosity mu = 1.3076e-3 "Dynamic viscosity of water at T_0"
    annotation (Dialog(group = "Waterway properties"));
  parameter SI.Height p_eps = 0 "Pipe roughness height (default is smooth pipe)"
    annotation (Dialog(group = "Waterway properties"));
  parameter SI.Compressibility beta = 4.5e-10 "Water compressibility"
    annotation (Dialog(group = "Waterway properties"));
  parameter SI.Compressibility beta_total = 1 / (rho*1000^2) "Total compressibility"
   annotation (Dialog(group = "Waterway properties"));
  parameter Boolean SteadyState=false "If checked, simulation starts in steady state"
    annotation (choices(checkBox = true), Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0 = 0 "Initial volume flow rate through the system"
    annotation (Dialog(group="Initialization"));
  parameter SI.Frequency f_0 = 50 "Initial system frequency"
    annotation (Dialog(group = "Initialization"));
  final parameter Boolean TempUse = false "If checked, the water temperature is not constant"
    annotation (choices(checkBox = true), Dialog(group = "Thermal behaviour (not yet implemented)",
      enable = false));
  parameter SI.Temperature T_0(displayUnit="degC") = 283.15 "Initial water temperature"
    annotation (Dialog(group = "Thermal behaviour (not yet implemented)", enable = TempUse));
  parameter SI.SpecificHeatCapacity c_p = 4200 "Heat capacity of water at T_0"
    annotation (Dialog(group = "Thermal behaviour (not yet implemented)", enable = TempUse));
  annotation (
    Documentation(info = "<html><p>Here a common data set for this library is defined. </p>
    <p>It is possible to insert this class to models and use the common data set for the respective model.</p>
    </html>"),
    defaultComponentName = "data",
    defaultComponentPrefixes = "inner",
    missingInnerMessage = "No 'data' component is defined. A default component will be used and provide system parameters");
end Data;
