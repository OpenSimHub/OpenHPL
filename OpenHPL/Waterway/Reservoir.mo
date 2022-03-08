within OpenHPL.Waterway;
model Reservoir "Model of the reservoir"
  outer Data data "using standard class with constants";
  extends OpenHPL.Icons.Reservoir;
  //// constant water level in the reservoir
  parameter Boolean useLevel=false "If checked, input Level_in controls the water level of the reservoir"
    annotation (
    Dialog(group="Setup", enable=not useInFlow),
    choices(checkBox = true));
  parameter Boolean useInFlow=false "If checked, the inlet flow connector is used"   annotation (
    Dialog(group="Setup", enable=not useLevel),
    choices(checkBox = true));
  parameter Modelica.SIunits.Height H_r = 50 "Initial water level above intake"
    annotation (Dialog(group = "Setup", enable=not useLevel));
  //// geometrical parameters in case when the inflow to reservoir is used
  parameter Modelica.SIunits.Length L = 500 "Length of the reservoir" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Length w = 100 "Bed width of the reservoir" annotation (
    Dialog(group = "Geometry"));
  parameter Modelica.SIunits.Angle alpha = 0 "The angle of the reservoir walls (zero angle corresponds to vertical walls)" annotation (
    Dialog(group = "Geometry"));
  parameter Real f = 0.0008 "Friction factor of the reservoir" annotation (
    Dialog(group = "Geometry"));
  //// conditions of use


  //// possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter Modelica.SIunits.Temperature T_0 = data.T_0 "Initial temperature of the water" annotation (Dialog(group = "Initialization", enable = TempUse));

  Modelica.SIunits.Area A "Vertical cross section";
  Modelica.SIunits.Mass m "Water mass";
  Modelica.SIunits.MassFlowRate mdot "Water mass flow rate";
  Modelica.SIunits.VolumeFlowRate Vdot_i "Inlet flow rate";
  Modelica.SIunits.VolumeFlowRate Vdot_o "Outlet flow rate";
  Modelica.SIunits.VolumeFlowRate Vdot "Flow rate through the reservoir";
  Modelica.SIunits.Velocity v "Water velocity";
  Modelica.SIunits.Momentum M "Water momentum";
  Modelica.SIunits.Force F_f "Friction force";
  Modelica.SIunits.Height H "Water level";
  Modelica.SIunits.Pressure p_o "Outlet pressure";

  OpenHPL.Interfaces.Contact_o o(p=p_o) "Outflow from reservoir" annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput V_in = Vdot_i if useInFlow "Conditional input inflow of the reservoir"
    annotation (Placement(transformation(origin={-120,0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput Level_in=H if useLevel "Conditional input water level of the reservoir"
    annotation (Evaluate=true, Placement(transformation(extent={{-140,40},{-100,80}},
                                                                                    rotation=0)));

initial equation
   if not useLevel then
     H = H_r;
   end if;
equation
  A = H * (w + H * Modelica.Math.tan(alpha))
    "Vertical cross section of the reservoir";
  m = data.rho * A * L "Water mass in reservoir";
  Vdot = Vdot_i - Vdot_o "Volumetric water flow rate";
  mdot = data.rho * Vdot "Water mass flow rate";
  v = mdot / data.rho / A "Water velocity";
  M = L * mdot "Momentum based on the length";
  F_f = 1 / 8 * data.rho * f * L * (w + 2 * H / Modelica.Math.cos(alpha)) * v * abs(v)
   "Friction force due to movement along the reservoir length";
  if useLevel then
    Vdot_i - Vdot_o = 0;
    p_o = data.p_a + data.g*data.rho*H;
  elseif useInFlow then
    der(M) = A*(data.p_a - p_o) + data.g*data.rho*A*H - F_f + data.rho/A*(Vdot_i^2 - Vdot_o^2);
    der(m) = mdot;
  else
    Vdot_i = 0;
    p_o = data.p_a + data.g*data.rho*H;
    der(m) = mdot;
  end if;

   o.mdot = -data.rho * Vdot_o "Output flow connector";
  //o.T = T_0 "TBD: Output temperature connector";
  annotation ( Documentation(info="<html>
<p>Simple model of the reservoir with different options:</p>
<ul>
<li><em>Default</em>: Container with an initial water level of <code>H_0</code>. 
 The water level will vary according to the outlet volume flow rate.</li>
<li><code>useLevel</code>: The water level is determined by the <code>level</code> input.
<li><code>useInflow</code>: Reservoir starts with an initial water level of <code>H_0</code>
 but uses the <code>inflow</code> input as additional water source (can also be negative 
to simulate evaporation.</li>
</ul>
<p>
<img src=\"modelica://OpenHPL/Resources/Images/Reservoir.svg\">
</p>
</html>"),
    experiment(StartTime = 0, StopTime = 3600, Tolerance = 0.0001, Interval = 1));
end Reservoir;
