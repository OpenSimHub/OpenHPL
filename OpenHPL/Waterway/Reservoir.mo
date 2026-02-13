within OpenHPL.Waterway;
model Reservoir "Model of the reservoir"
  outer Data data "using standard class with constants";
  extends OpenHPL.Icons.Reservoir;
  parameter SI.Height h_0=50 "Initial water level above intake"
    annotation (Dialog(group="Setup", enable=not useLevel));
  parameter Boolean constantLevel=false "If checked, the reservoir keeps the constant water level h_0"
    annotation (
    Dialog(group="Setup", enable=not (useInflow or useLevel)),
    choices(checkBox = true));
  parameter Boolean useLevel=false "If checked, the \"level\" connector controls the water level of the reservoir"
    annotation (
    Dialog(group="Setup", enable=not (useInflow or constantLevel)),
    choices(checkBox = true));
  parameter Boolean useInflow=false "If checked, the \"inflow\" connector is used" annotation (
    Dialog(group="Setup", enable=not (useLevel or constantLevel)),
    choices(checkBox = true));
  parameter SI.Length L=500 "Length of the reservoir" annotation (
    Dialog(group="Geometry"));
  parameter SI.Length W=100 "Bed width of the reservoir" annotation (
    Dialog(group="Geometry"));
  parameter SI.Angle alpha = 0 "The angle of the reservoir walls (zero angle corresponds to vertical walls)" annotation (
    Dialog(group = "Geometry"));
  parameter Real f = 0.0008 "Friction factor of the reservoir" annotation (
    Dialog(group = "Geometry"));

  // possible parameters for temperature variation. Not finished...
  //parameter Boolean TempUse = data.TempUse "If checked - the water temperature is not constant" annotation (Dialog(group = "Initialization"));
  //parameter SI.Temperature T_0 = data.T_0 "Initial temperature of the water" annotation (Dialog(group = "Initialization", enable = TempUse));

  SI.Area A "Vertical cross section";
  SI.Mass m "Water mass";
  SI.MassFlowRate mdot "Water mass flow rate";
  SI.VolumeFlowRate Vdot_i "Inlet flow rate";
  SI.VolumeFlowRate Vdot_o "Outlet flow rate";
  SI.VolumeFlowRate Vdot "Flow rate through the reservoir";
  SI.Velocity v "Water velocity";
  SI.Momentum M "Water momentum";
  SI.Force F_f "Friction force";
  SI.Height h "Water level";
  SI.Pressure p_o "Outlet pressure";

  OpenHPL.Interfaces.Contact_o o(p=p_o) "Outflow from reservoir" annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Blocks.Interfaces.RealInput inflow=Vdot_i if useInflow "Conditional input inflow of the reservoir" annotation (Placement(transformation(
        origin={-120,0},
        extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Interfaces.RealInput level=h if useLevel "Conditional input water level of the reservoir" annotation (Evaluate=true, Placement(transformation(extent={{-140,40},{-100,80}})));

initial equation
   if not useLevel then
    h = h_0;
   end if;
equation
  A =h * (W +h * Modelica.Math.tan(alpha))
    "Vertical cross section of the reservoir";
  m = data.rho * A *L "Water mass in reservoir";
  Vdot = Vdot_i - Vdot_o "Volumetric water flow rate";
  mdot = data.rho * Vdot "Water mass flow rate";
  v = mdot / data.rho / A "Water velocity";
  M =L * mdot "Momentum based on the length";
  F_f = 1 / 8 * data.rho * f *L * (W + 2 *h / Modelica.Math.cos(alpha)) * v * abs(v)
   "Friction force due to movement along the reservoir length";
  if constantLevel then
    h = h_0;
    Vdot_i - Vdot_o = 0;
    p_o = data.p_a + data.g*data.rho*h;
  elseif useLevel then
    Vdot_i - Vdot_o = 0;
    p_o = data.p_a + data.g*data.rho*h;
  elseif useInflow then
    der(M) = A*(data.p_a - p_o) + data.g*data.rho*A*h - F_f + data.rho/A*(Vdot_i^2 - Vdot_o^2);
    der(m) = mdot;
  else
    Vdot_i = 0;
    p_o = data.p_a + data.g*data.rho*h;
    der(m) = mdot;
  end if;

   o.mdot = -data.rho * Vdot_o "Output flow connector";
  //o.T = T_0 "TBD: Output temperature connector";
  annotation (Documentation(info="<html>
<h4>Reservoir Model</h4>

<p>Simple model of the reservoir with different options for modeling the water source of a hydropower system.</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/Reservoir.svg\">
</p>
<p><em>Figure: Reservoir model schematic.</em></p>

<h5>Model Variants</h5>
<ul>
<li><em>Default (Simple)</em>: Container with an initial water level of <code>H_0</code>.
 The water level will vary according to the outlet volume flow rate.</li>
<li><code>useLevel</code>: The water level is determined by the <code>level</code> input signal,
allowing external control of the (varying) reservoir levels.</li>
<li><code>useInflow</code>: Reservoir starts with an initial water level of <code>H_0</code>
 but uses the <code>inflow</code> input as additional water source (can also be negative
to simulate evaporation or other losses).</li>
</ul>

<h5>Governing Equations</h5>

<p><strong>Simplified Model:</strong> In the simple case with constant or slowly varying reservoir level,
the reservoir outlet pressure is simply:</p>
<p>$$ p_\\mathrm{o} = p_\\mathrm{atm} + \\rho g H $$</p>

<p><strong>Detailed Model:</strong> For a detailed model with dynamics and inflow,
the mass and momentum balances are:</p>
<p>$$ H\\frac{\\mathrm{d}\\dot{m}}{\\mathrm{d}t} = \\frac{\\rho}{A}\\dot{V}^2 + A(p_\\mathrm{atm}-p_\\mathrm{o}) + \\rho gHA - F_\\mathrm{f,r} $$</p>
<p>$$ \\frac{\\mathrm{d}m}{\\mathrm{d}t} = \\dot{m}_\\mathrm{i} - \\dot{m}_\\mathrm{o} $$</p>
<p>where ṁ is the reservoir mass flow rate, A is the cross-sectional area,
p<sub>atm</sub> and p<sub>o</sub> are atmospheric and outlet pressures, and F<sub>f,r</sub> is
the friction term (typically small for large reservoirs).</p>
</html>"));
end Reservoir;
