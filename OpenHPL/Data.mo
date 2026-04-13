within OpenHPL;
record Data "Provides a data set of most common used settings"
  extends Modelica.Icons.Record;
  parameter Boolean showElevation=true "Display elevation of connectors"
    annotation(Dialog(group = "Icon"),
    choices(checkBox = true));
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
  parameter Types.FrictionMethod FrictionMethod = Types.FrictionMethod.PipeRoughness "Default friction specification method"
    annotation (Dialog(group = "Friction"));
  parameter SI.Height p_eps_input = 0 "Pipe roughness height (for PipeRoughness method)"
    annotation (Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.PipeRoughness));
  parameter Real f_moody(min=0) = 0.02 "Moody friction factor (used when FrictionMethod = MoodyFriction)"
    annotation (Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.MoodyFriction));
  parameter Real m_manning(unit="m(1/3)/s", min=0) = 40 "Manning M (Strickler) coefficient (used when FrictionMethod = ManningFriction)"
    annotation (Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction and not use_n));
  parameter Boolean use_n = false "If true, use Manning's n instead of M"
    annotation (Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction), choices(checkBox=true));
  parameter Real n_manning(unit="s/m(1/3)", min=0) = 0.025 "Manning's n coefficient (used when FrictionMethod = ManningFriction and use_n)"
    annotation (Dialog(group = "Friction", enable = FrictionMethod == Types.FrictionMethod.ManningFriction and use_n));
  parameter SI.Diameter D_h = 1.0 "Reference hydraulic diameter for friction conversion (used for Moody/Manning)"
    annotation (Dialog(group = "Friction", enable = FrictionMethod <> Types.FrictionMethod.PipeRoughness));
  final parameter Real n_eff_ = if use_n then n_manning else 1/m_manning "Effective Manning's n coefficient";
  final parameter SI.Height p_eps = if FrictionMethod == Types.FrictionMethod.PipeRoughness then p_eps_input
                                     elseif FrictionMethod == Types.FrictionMethod.MoodyFriction then 3.7 * D_h * 10^(-1/(2*sqrt(f_moody)))
                                     else D_h * 3.0971 * exp(-0.118/n_eff_) "Computed equivalent pipe roughness height";
  parameter SI.Compressibility beta = 4.5e-10 "Water compressibility"
    annotation (Dialog(group = "Waterway properties"));
  parameter SI.Compressibility beta_total = 1 / (rho*1000^2) "Total compressibility"
   annotation (Dialog(group = "Waterway properties"));
  parameter SI.Frequency f_grid=50 "Grid frequency"  annotation (Dialog(group = "System properties"));
  parameter Boolean SteadyState=false "If checked, simulation starts in steady state"
    annotation (choices(checkBox = true), Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0 = 0 "Initial volume flow rate through the system"
    annotation (Dialog(group="Initialization"));
  parameter SI.PerUnit f_0 = 1 "Initial unit speed"
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
