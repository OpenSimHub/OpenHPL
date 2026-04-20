within OpenHPL.Waterway;
model Pipe "Model of a pipe"
  outer Data data "Using standard data set";
  extends OpenHPL.Icons.Pipe;
  extends OpenHPL.Interfaces.TwoContacts;
  extends Types.FrictionSpec(   final D_h = (D_i + D_o) / 2);

  // Geometrical parameters of the pipe:
  parameter SI.Length H = 0 "Height difference from the inlet to the outlet" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Length L = 1000 "Length of the pipe" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_i = 1.0 "Diameter of the inlet side" annotation (
    Dialog(group = "Geometry"));
  parameter SI.Diameter D_o = D_i "Diameter of the outlet side" annotation (
    Dialog(group = "Geometry"));

  // Steady state:
  parameter Boolean SteadyState=data.SteadyState "If true, starts in steady state" annotation (Dialog(group="Initialization"));
  parameter SI.VolumeFlowRate Vdot_0=data.Vdot_0 "Initial flow rate of the pipe" annotation (Dialog(group="Initialization"));
  parameter Boolean useInitialFlow=true "If false, skip initial equation for flow (e.g., when flow is imposed by a source)"
    annotation (Dialog(group="Initialization"), choices(checkBox=true));

  SI.Velocity v "Average Water velocity";
  SI.Force F_f "Friction force";
  SI.Pressure p_i "Inlet pressure";
  SI.Pressure p_o "Outlet pressure";
  SI.Pressure dp=p_o-p_i "Pressure difference across the pipe";
  SI.MassFlowRate mdot "Mass flow rate";
  SI.VolumeFlowRate Vdot "Volume flow rate";

protected
    parameter SI.Diameter D_ = ( D_i + D_o)  / 2 "Average diameter";
    
    parameter SI.Area A_ =  D_  ^ 2 * C.pi / 4 "Average cross-sectional area";
    parameter Real delta=2*(D_i-D_o)/(D_i+D_o) "Contraction factor";
    parameter Real cf=1+2*delta^2 "Conical pipe function";
    parameter Real cos_theta = H / L "Slope ratio";
    parameter Modelica.Units.NonSI.Angle_deg phi = Modelica.Units.Conversions.to_deg(Modelica.Math.atan((abs(D_i-D_o)/(2*L)))) "Cone half angle";

initial equation
  if useInitialFlow then
    if SteadyState then
      der(mdot) = 0;
    else
      Vdot=Vdot_0;
    end if;
  end if;
algorithm
    assert( phi < 1.0,  "Change in pipe diameter is too large. (angle= "+String(phi)+" )",AssertionLevel.warning);
equation

  Vdot = mdot / data.rho "Volumetric flow rate through the pipe";
  v = Vdot / A_ "Average water velocity";
  F_f = Functions.DarcyFriction.Friction(v, D_, L, data.rho, data.mu, p_eps)*cf "Friction force";
  L * der(mdot)=(p_i+ data.rho *data.g * H-p_o)*A_ -F_f;
  p_i = i.p "Inlet pressure";
  p_o = o.p "Outlet pressure";
  i.mdot+o.mdot = 0 "Mass balance";
  mdot = i.mdot "Inlet direction for mdot";
  o.elevation.z = i.elevation.z - H "Elevation propagation: outlet is H below inlet";

  annotation (preferredView="info",
    Documentation(info="<html>
<h4>Simple Pipe Model</h4>

<p>The simple model of the pipe gives possibilities for easy modelling of different conduit: intake race,
penstock, tail race, etc. The model assumes incompressible water and inelastic walls since there are only
small pressure variations.</p>

<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/pipe.svg\"> </p>
<p><em>Figure: Model for flow through a pipe.</em></p>

<h5>Mass and Momentum Balance</h5>

<p><strong>Mass Balance:</strong> For incompressible water, the mass in the filled pipe is constant:</p>
<p>$$ \\frac{\\mathrm{d}m_\\mathrm{c}}{\\mathrm{d}t} = \\dot{m}_\\mathrm{c,in} - \\dot{m}_\\mathrm{c,out} = 0 $$</p>

<p><strong>Momentum Balance:</strong> The momentum balance is expressed as:</p>
<p>$$ \\frac{\\mathrm{d}M_\\mathrm{c}}{\\mathrm{d}t} = \\dot{M}_\\mathrm{c,in} - \\dot{M}_\\mathrm{c,out} + F_\\mathrm{p,c} + F_\\mathrm{g,c} + F_\\mathrm{f,c} $$</p>
<p>where:</p>
<ul>
<li>M<sub>c</sub> = m<sub>c</sub> v<sub>c</sub> is the momentum</li>
<li>F<sub>p,c</sub> is the pressure force due to inlet/outlet pressure difference</li>
<li>F<sub>g,c</sub> = m<sub>c</sub> g cos θ<sub>c</sub> is the gravity force</li>
<li>F<sub>f,c</sub> is the friction force calculated using the Darcy friction factor</li>
</ul>

<p>This model is described by the momentum differential equation, which depends on pressure drop through the pipe
together with friction and gravity forces. The main defined variable is volumetric flow rate <code>Vdot</code>.</p>

<p>In this pipe model, the flow rate changes simultaneously in the whole pipe (information about the speed of wave
propagation is not included). Water pressures are shown at the pipe boundaries (inlet and outlet pressure from connectors).</p>

<h5>Features</h5>
<p>It should be noted that this pipe model provides possibilities for modelling of pipes with both positive and negative
slopes (positive or negative height difference).</p>

<p>If the pipe is slightly tapered then this can be taken into account by adjusting <code>K_c</code> based on your
taper geometry: 0.05–0.15 for gentle cones, up to 0.6 for sharp contractions.</p>

<h5>Friction Specification</h5>
<p>Friction is specified via the inherited <a href=\"modelica://OpenHPL.Waterway.BaseClasses.FrictionSpec\">FrictionSpec</a>
base class, which supports pipe roughness, Moody friction factor, and Manning coefficient methods.</p>

<h5>Initialization</h5>
<p>By default, the pipe provides an initial equation for the flow rate: either <code>der(mdot) = 0</code>
(steady state) or <code>Vdot = Vdot_0</code>. When the pipe is connected to a component that already
imposes the flow (e.g., <code>VolumeFlowSource</code>), these initial equations become redundant and may
cause an over-determined initialization problem in some tools (e.g., Dymola). Set
<code>useInitialFlow = false</code> to disable the initial equation in such cases.</p>

<h5>More Information</h5>
<p>More info about the pipe model can be found in
    <a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2017]</a>
and <a href=\"modelica://OpenHPL.UsersGuide.References\">[Splavska2017a]</a>.</p>
</html>"));
end Pipe;
