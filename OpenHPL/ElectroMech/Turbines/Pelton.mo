within OpenHPL.ElectroMech.Turbines;
model Pelton "Model of the Pelton turbine"
  outer Data data "Using standard class with constants";
    extends Icons.Turbine;
    import Modelica.Constants.pi;
    // geometrical parameters of the turbine
    parameter SI.Radius R = 3.3 "Radius of the turbine";
    parameter SI.Diameter D_0 = 3.3 "Input diameter of the nozzle";
    parameter Real k = 0.8 "Friction factor", k_f = 1 "Coefficient of friction loss in the nozzle", K = 0.25 "Friction loss coefficient due to power loss", d_u = 1 "Deflector mechanism coefficient";
  parameter Modelica.Units.NonSI.Angle_deg beta=165;
    // condition for inlet water compressibility
    parameter Boolean CompElas = false "If checked the water is compressible and the walls is elastic" annotation (
        choices(checkBox = true));
    // variables
    SI.Pressure p_tr1 "Inlet pressure", dp_tr "Turbine pressure drop", p_tr2 "Outlet pressure", dp_n "Nuzzel pressure drop";
    SI.Area A_1, A_0 = pi * D_0 ^ 2 / 4;
    SI.EnergyFlowRate Wdot_s "Shaft power";
    SI.VolumeFlowRate Vdot "Flow rate";
    SI.MassFlowRate mdot "Mass flow rate";
    SI.Velocity v_R, v_1;
    SI.AngularVelocity w=w_in "Angular velocity";
    Real cos_b = Modelica.Math.cos(Modelica.Units.Conversions.from_deg(beta));
    // connectors
    extends OpenHPL.Interfaces.TurbineContacts(enable_P_out=true);
    Modelica.Blocks.Interfaces.RealInput w_in "Input angular velocity from the generator" annotation (
                                Placement(transformation(origin={-120,-80}, extent={{-20,-20},
            {20,20}})));
protected
  Modelica.Blocks.Interfaces.RealOutput p_out=Wdot_s "Internal connector for output power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,90})));
equation
  // Condition for inlet water compressibility
    if not CompElas then
        Vdot = mdot / data.rho;
    else
        Vdot = mdot / (data.rho * (1 + data.beta * (i.p - data.p_a)));
    end if;
  // nozzel pressure drop
    dp_n = 0.5 * mdot * (Vdot * (1 / A_1 ^ 2 - 1 / A_0 ^ 2) + k_f);
  // Euler equation for shaft power
    Wdot_s = mdot * v_R * (d_u * v_1 - (1 + K) * v_R) * (1 - k * cos_b);
    v_R = w * R;
    v_1 = Vdot / A_1;
    A_1 = u_t;
  // turbine pressure drop
    dp_tr * Vdot = Wdot_s;
    dp_tr = p_tr1 - p_tr2;
  // connectors pressures
    p_tr1 = i.p;
  // + dp_n;
    p_tr2 = o.p;
  // Flow rate connectors
    i.mdot+o.mdot=0;
    mdot=i.mdot;

  connect(p_out, P_out) annotation (Line(points={{40,90},{40,110}}, color={0,0,127}));
    annotation (
        Documentation(info="<html>
<h4>Pelton Turbine Model</h4>
<p>Mechanistic Pelton turbine model based on the Euler turbine equation and impulse turbine principles.</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinepelton.svg\" alt=\"Pelton turbine\" width=\"600\"/>
</p>
<p><em>Figure: Key concepts of the Pelton turbine.</em></p>

<h5>Shaft Power</h5>
<p>The shaft power \\(\\dot{W}_s\\) produced in the Pelton turbine is:</p>
<p>$$ \\dot{W}_s=\\dot{m}v_R\\left[\\delta(u_\\delta)\\cdot v_1-v_R\\right]\\left(1-k\\cos\\beta\\right) $$</p>
<p>where:</p>
<ul>
<li>\\(\\dot{m}\\) is the mass flow rate through the turbine</li>
<li>\\(v_R = \\omega R\\) is the reference velocity (\\(R\\) = radius of rotor where flow hits the bucket, \\(\\omega\\) = angular velocity constrained by grid frequency)</li>
<li>\\(v_1=\\frac{\\dot{V}}{A_1}\\) is water velocity at position \"1\" (end of nozzle), with \\(\\dot{V}\\) = volumetric flow rate and \\(A_1\\) = cross-sectional area</li>
<li>\\(\\beta\\) is the reflection angle (typically \\(\\beta= 165^{\\circ}\\))</li>
<li>\\(k<1\\) is a friction factor (typically \\(k\\in[0.8, 0.9]\\))</li>
<li>\\(\\delta(u_\\delta)\\) represents deflector mechanism to reduce velocity and avoid over-speed</li>
</ul>

<h5>Total Work and Friction Losses</h5>
<p>Total work rate removed through the turbine:</p>
<p>$$ {\\dot{W}_t} = {\\dot{W}_s+\\dot{W}_{ft}} $$</p>
<p>Friction losses:</p>
<p>$$ \\dot{W}_{ft}=K\\left(1-k\\cos\\beta\\right)\\dot{m}v_R^2 $$</p>
<p>with friction coefficient \\(K=0.25\\).</p>

<h5>Nozzle Pressure Drop</h5>
<p>Pressure drop across the nozzle (positions \"0\" and \"1\"):</p>
<p>$$ \\Delta p_n=\\frac{1}{2}\\rho\\dot{V}\\left[\\dot{V}\\left(\\frac{1}{A_1^2(Y)}-\\frac{1}{A_0^2}\\right)+k_f\\right] $$</p>
<p>where \\(A_0\\) is cross-sectional area at nozzle beginning, \\(A_1(Y)\\) is area at nozzle end (function of needle position Y), 
and \\(k_f\\) is the nozzle friction loss coefficient.</p>

<h5>Connectors</h5>
<ul>
<li><a href=\"modelica://OpenHPL.Interfaces.TurbineContacts\">TurbineContacts</a> for connection to waterway and electro-mechanical units</li>
<li>RealInput connector for angular velocity (typically from generator)</li>
</ul>

<h5>Parameters</h5>
<p>User specifies: turbine runner radius, nozzle input diameter, runner bucket angle, friction factors and coefficients, 
deflector mechanism coefficient.</p>

<p><em>Note: This model has not been tested.</em></p>
<p>More info in: <a href=\"modelica://OpenHPL/Resources/Documents/Turbines_model.pdf\">Resources/Documents/Turbines_model.pdf</a></p>
</html>"));
end Pelton;
