within OpenHPL.Waterway;
model Reservoir "Model of the reservoir"
  outer Data data "using standard class with constants";
  extends OpenHPL.Icons.Reservoir;
  //// constant water level in the reservoir
  parameter Modelica.SIunits.Height H_r = 50 "Initial water level above intake" annotation (
    Dialog(group = "Initialization"));
  //// geometrical parameters in case when the inflow to reservoir is used
  parameter Modelica.SIunits.Length L = 500 "Length of the reservoir" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length w = 100 "Bed width of the reservoir" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg alpha = 30 "The angle of the reservoir walls (zero angle corresponds to vertical walls)" annotation (
    Dialog(group = "Geometry"));
  parameter Real f = 0.0008 "Friction factor of the reservoir" annotation (
    Dialog(group = "Geometry"));
  //// conditions of use
  parameter Boolean UseInFlow = false "If checked - the inlet/outlet flow is used" annotation (
    Dialog(group = "Structure"),
    choices(checkBox = true));
  parameter Boolean Input_level = false "If checked - the input Level_in should be connected. Otherwise the constant level H_r is used" annotation (
    Dialog(group = "Structure"),
    choices(checkBox = true));
  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_0 = data.T_0 "Initial temperature of the water" annotation (Dialog(group = "Initialization", enable = TempUse));
  //// variables
  Modelica.SIunits.Area A "vertiacal cross section";
  Modelica.SIunits.Mass m "water mass";
  Modelica.SIunits.MassFlowRate mdot "water mass flow rate";
  Modelica.SIunits.VolumeFlowRate Vdot_o "outlet flow rate", Vdot_i "inlet flow rate", Vdot "vertical flow rate";
  Modelica.SIunits.Velocity v "water velosity";
  Modelica.SIunits.Momentum M "water momentum";
  Modelica.SIunits.Force F_f "friction force";
  Modelica.SIunits.Height H "water height";
  Modelica.SIunits.Pressure p_o "outlet pressure";
  //// conectors
  OpenHPL.Interfaces.Contact o(p=p_o) "Outflow from reservoir" annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput V_in = Vdot_i if UseInFlow "Conditional input inflow of the reservoir"
    annotation (Placement(transformation(origin={-120,0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Level_in = H if Input_level "Conditional input water level of the reservoir"
    annotation (Placement(transformation(origin={-120,50}, extent = {{-20, -20}, {20, 20}}, rotation=0)));
initial equation
  if Input_level == false then
    H = H_r;
  end if;
equation
  //// Define vertiacal cross section of the reservoir
  A = H * (w + 2 * H * Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(alpha)));
  //// Define water mass
  m = data.rho * A * L;
  //// Define volumetric water flow rate
  Vdot = Vdot_i - Vdot_o;
  //// Define mass water flow rate
  mdot = data.rho * Vdot;
  //// Define water velocity
  v = mdot / data.rho / A;
  //// Define momentrumn
  M = L * mdot;
  //// Define friction term
  F_f = 1 / 8 * data.rho * f * L * (w + 2 * H / Modelica.Math.cos(alpha)) * v * abs(v);
  //// condition for inflow use
  if UseInFlow == false then
    //// condition for constant water level, inflow = outflow
    Vdot_i - Vdot_o = 0;
  end if;
  //// condition for input water level use
  if Input_level == false then
    //// define derivatives of momentum and mass
    der(M) = A * (data.p_a - p_o) + data.g * data.rho * A * H - F_f + data.rho / A * (Vdot_i ^ 2 - Vdot_o ^ 2);
    der(m) = mdot;
  else
    //// define output pressure
    p_o = data.p_a + data.g * data.rho * H;
  end if;
  //// output flow conector
  o.mdot = -data.rho * Vdot_o;
  //// output temperature conector
  //o.T = T_0;
  annotation (
    Icon(coordinateSystem(initialScale = 0.1)),
    Documentation(info="<html>
<p>Simple model of the reservoir, which depending on depth of the outlet from reservoir, calculate the outlet pressure.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/Reservoir.svg\"></p>
<p>Can also make a more complicated model and add the inflow to the reservoir and specify the reservoir geometry.</p>
<p>Also, it is possible to connect an input signal with varying water level in the reservoir.</p>
</html>"),
    experiment(StartTime = 0, StopTime = 3600, Tolerance = 0.0001, Interval = 1));
end Reservoir;
