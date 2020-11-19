within OpenHPL.ElectroMech.Turbines;
model Turbine2 "Simple turbine model with mechanical connectors"
  outer Data data "Using standard class with global parameters";
  extends Icons.Turbine;
  extends OpenHPL.Interfaces.TurbineContacts2;

  parameter Boolean ValveCapacity =  true "If checked the guide vane capacity C_v should be specified, 
    otherwise specify the nominal turbine parameters (net head and flow rate)"
    annotation (Dialog(group = "Nominal turbine parameters"), choices(checkBox = true));
  parameter Real C_v = 3.7 "Guide vane 'valve capacity'"
    annotation (Dialog(group = "Nominal turbine parameters", enable = ValveCapacity));
  parameter SI.Height H_n = 460 "Nominal net head"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter SI.VolumeFlowRate Vdot_n = 23.4 "Nominal flow rate"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter SI.PerUnit u_n = 0.95 "Nominal guide vane opening"
    annotation (Dialog(group = "Nominal turbine parameters", enable = not ValveCapacity));
  parameter Boolean ConstEfficiency = true "If checked the constant efficiency eta_h is used,
    otherwise specify lookup table for efficiency"
    annotation (Dialog(group = "Efficiency data"), choices(checkBox = true));
  parameter SI.Efficiency eta_h = 0.9 "Turbine hydraulic efficiency"
    annotation (Dialog(group = "Efficiency data", enable = ConstEfficiency));
  parameter Real lookup_table[:, :] = [0, 0.4; 0.2, 0.7; 0.5, 0.9; 0.95, 0.95; 1.0, 0.93]
    "Look-up table for the turbine efficiency, described by a table matrix, 
     where the first column is a pu value of the guide vane opening,
     and the second column is a pu value of the turbine efficiency."
    annotation (Dialog(group = "Efficiency data", enable = not ConstEfficiency));
  parameter Boolean WaterCompress = false "If checked the water is compressible in the penstock"
    annotation (Dialog(tab = "Advanced"),  choices(checkBox = true));

  parameter SI.MomentOfInertia Jt = 2e5 "Moment of inertia of the turbine"
    annotation (Dialog(group = "Mechanical"));
  parameter SI.Power Ploss = 0 "Friction losses of turbine"
    annotation (Dialog(group = "Mechanical"));
  parameter Integer p = 12 "Number of poles of the connected generator"
    annotation (Dialog(group = "Mechanical"));
  parameter Modelica.SIunits.AngularVelocity w_0 = data.f_0 * 4 * C.pi / p "Initial angular velocity" annotation (
    Dialog(group = "Initialization"));

  SI.Pressure dp "Turbine pressure drop";
  SI.EnergyFlowRate Kdot_i_tr "Kinetic energy flow";
  SI.VolumeFlowRate Vdot "Flow rate";
  Real C_v_ "Guide vane 'valve capacity'";

  output SI.EnergyFlowRate Wdot_s "Shaft power";
  Modelica.Blocks.Tables.CombiTable1D look_up_table(table = lookup_table);
  Modelica.Mechanics.Rotational.Components.Inertia turbineIntertia(J=Jt, w(start=w_0, fixed=true))
                                                                                                  annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={0,0})));
  Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-28,-80})));
  Modelica.Electrical.Machines.Losses.Friction friction(frictionParameters(PRef=Ploss, wRef=data.f_0*4*C.pi/p))
                                                                                  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,20})));
  Modelica.Mechanics.Rotational.Components.Fixed fixed annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Mechanics.Rotational.Sources.Torque turbineTorque annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Division turbinePtoT annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Modelica.Constants.inf, uMin=Modelica.Constants.small) annotation (Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-60,-70})));
  Modelica.Blocks.Sources.RealExpression turbinePower(y=Wdot_s) annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
  Modelica.Mechanics.Rotational.Interfaces.Flange_b flange "Flange of turbine shaft" annotation (Placement(transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={{-10,20},{10,40}})));
equation
  Vdot = if WaterCompress then mdot / (data.rho * (1 + data.beta * (i.p - data.p_a))) else mdot / data.rho
    "Checking for water compressibility";
  look_up_table.u[1] = u_t "Link the guide vane opening";
  C_v_ = if ValveCapacity then C_v else Vdot_n/sqrt(H_n*data.g*data.rho/data.p_a)/u_n
    "Define guide vane 'valve capacity' base on the Nominal turbine parameters";
  dp = Vdot ^ 2 * data.p_a / (C_v_ * u_t) ^ 2 "turbine valve equation for pressure drop";
  dp = i.p - o.p "Link the pressure drop to the ports";
  Kdot_i_tr = dp * Vdot "Turbine energy balance";
  if ConstEfficiency == true then
    Wdot_s = eta_h * Kdot_i_tr;
  else
    Wdot_s = look_up_table.y[1] * Kdot_i_tr;
  end if;

  //P_out = Wdot_s "Link the output power";

  /* // for temperature variation, not finished...
  i.T = o.T; */

  connect(friction.support,fixed. flange) annotation (Line(points={{30,20},{40,20},{40,0}},
                                                                                     color={0,0,0}));
  connect(turbinePtoT.y,turbineTorque. tau) annotation (Line(points={{-29,-30},{-22,-30}},           color={0,0,127}));
  connect(speedSensor.w, limiter.u) annotation (Line(points={{-39,-80},{-60,-80},{-60,-77.2}},
                                                                                             color={0,0,127}));
  connect(limiter.y, turbinePtoT.u2) annotation (Line(points={{-60,-63.4},{-60,-36},{-52,-36}},
                                                                                             color={0,0,127}));
  connect(turbineIntertia.flange_a, turbineTorque.flange) annotation (Line(points={{-4.44089e-16,-10},{0,-10},{0,-30}},
                                                                                                   color={0,0,0}));
  connect(speedSensor.flange, turbineTorque.flange) annotation (Line(points={{-18,-80},{0,-80},{0,-30}}, color={0,0,0}));
  connect(turbineIntertia.flange_b, flange) annotation (Line(points={{0,10},{0,10},{0,100}}, color={0,0,0}));
  connect(P_out, turbinePower.y) annotation (Line(points={{40,110},{40,80},{-60,80},{-60,-24},{-69,-24}}, color={0,0,127},
      pattern=LinePattern.Dash));
  connect(friction.flange, flange) annotation (Line(points={{10,20},{0,20},{0,100}}, color={0,0,0}));
  connect(turbinePower.y, turbinePtoT.u1) annotation (Line(points={{-69,-24},{-52,-24}},
                                                                                       color={0,0,127}));
  connect(P_out, P_out) annotation (Line(
      points={{40,110},{40,105},{40,105},{40,110}},
      color={0,0,127},
      smooth=Smooth.Bezier));
  annotation (
    Documentation(info="<html><p>
This is a simple model of the turbine that give possibilities for simplified
modelling of the turbine unit. The model can use a constant efficiency or varying
efficiency from a lookup-table.
This model does not include any information about rotational speed of the runner.
</p>
<p>
This model is baseed on the energy balance and a simple valve-like expression.
The guide vane 'valve capacity' should be used for this valve-like expression and can either be specified
directly by the user by specifying <code>C_v</code> or it will be calculated from
the Nominal turbinenet head <code>H_n</code> and nominal flow rate
<code>Vdot_n</code>.
</p>
<p>
The turbine efficiency is in per-unit values from 0 to 1, where 1 means that there are no losses in the turbine.
The output mechanical power is defined as multiplication of the turbine efficiency and the total possible power:
</p>
<blockquote>
<pre>turbine_pressure_drop * turbine_flow_rate</pre>
</blockquote>
<p>Besides hydraulic input and output,
there are inputs as the control signal for the valve opening and also output as the turbine shaft power.
</p>

<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinepic.svg\">
</p><h5>References</h5><p>More info about the model can be found in:&nbsp;<a href=\"Resources/Report/Report.docx\">Resources/Report/Report.docx</a></p>
</html>"), Icon(graphics={Text(
          visible=enableP_out,
          extent={{30,100},{50,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="P"), Text(
          extent={{-96,100},{-60,80}},
          lineColor={0,0,0},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          textString="GVO")}));
end Turbine2;
