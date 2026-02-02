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
<p>This is a model of the Pelton turbine.
This model is based on the Euler turbine equation.
</p>
<p>
<em>The model has not been tested.</em></p>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinepelton.svg\">
</p>
<p>More info about the model can be found in:
<a href=\"modelica://OpenHPL/Resources/Documents/Turbines_model.pdf\">Resources/Documents/Turbines_model.pdf</a>
</p>
</html>"));
end Pelton;
