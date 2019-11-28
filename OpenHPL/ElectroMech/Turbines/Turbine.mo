within OpenHPL.ElectroMech.Turbines;
model Turbine "Simple turbine model"
  outer Data data "Using standard class with constants";
  extends Icons.Turbine;
  import Modelica.Constants.pi;
  //// parameters of the turbine
  parameter Boolean ValveCapacity =  true "If checked the guide vane capacity C_v should be specified, otherwise specify the nominal turbine parameters (net head and flow rate)" annotation (
    Dialog(group = "Turbine nominal parameters"), choices(checkBox = true));
  parameter Real C_v = 3.7 "Guide vane 'valve capacity'" annotation (
    Dialog(group = "Turbine nominal parameters", enable = ValveCapacity));
  parameter Modelica.SIunits.Height H_n = 460 "Turbine nominal net head" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));
  parameter Modelica.SIunits.VolumeFlowRate V_dot_n = 23.4 "Turbine nominal flow rate" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));
  parameter Real u_n = 0.95 "Turbine guide vane nominal opening, pu" annotation (
    Dialog(group = "Turbine nominal parameters", enable = not ValveCapacity));
  //// condition for efficiency
  parameter Boolean ConstEfficiency = true "If checked the constant efficiency theta_h is used,
    otherwise specify lookup table for efficiency"
    annotation (
    Dialog(group = "Efficiency data"),
    choices(checkBox = true));
  //// turbine efficiency, either constant theta_h or varying with flow (control signal) from lookup-table.
  parameter Modelica.SIunits.Efficiency theta_h = 0.9 "Turbine hydraulic efficiency" annotation (
    Dialog(group = "Efficiency data", enable = ConstEfficiency));
  parameter Real lookup_table[:, :] = [0, 0.4; 0.2, 0.7; 0.5, 0.9; 0.95, 0.95; 1.0, 0.93] "Look-up table for the turbine efficiency, described by a table matrix, where the first column is a pu value of the guide vane opening, and the second column is a pu value of the turbine efficiency" annotation (
    Dialog(group = "Efficiency data", enable = not ConstEfficiency));
  //// condition for inlet water compressibility
  parameter Boolean WaterCompress = false "If checked the water is compressible in the penstock" annotation (
    choices(checkBox = true));
  //// variables
  Modelica.SIunits.Pressure p_i_tr "Inlet pressure", dp "Turbine pressure drop", p_o_tr "Outlet pressure";
  //Modelica.SIunits.Area A_d = D_o ^ 2 * pi / 4, A_p = D_i ^ 2 * pi / 4;
  Modelica.SIunits.EnergyFlowRate K_i_tr_dot "Kinetic energy flow";
  Modelica.SIunits.VolumeFlowRate V_dot "Flow rate";
  Real C_v_ "Guide vane 'valve capacity'";
  output Modelica.SIunits.EnergyFlowRate W_s_dot "Shaft power";
  //// connectors
  extends OpenHPL.Interfaces.TurbineContacts;
  Modelica.Blocks.Tables.CombiTable1D look_up_table(table = lookup_table);
equation
  //// checking water compressibility
  V_dot = if WaterCompress then m_dot / (data.rho * (1 + data.beta * (i.p - data.p_a))) else m_dot / data.rho;
  //// define turbine efficiency
  look_up_table.u[1] = u_t;
  //// define guide vane 'valve capacity' base on the turbine nominal parameters
  C_v_ = if ValveCapacity then C_v else V_dot_n/sqrt(H_n*data.g*data.rho/data.p_a)/u_n;
  //// turbine valve equation for pressure drop
  dp = V_dot ^ 2 * data.p_a / (C_v_ * u_t) ^ 2;
  dp = p_i_tr - p_o_tr;
  //// turbine energy balance
  K_i_tr_dot = dp * V_dot;
  if ConstEfficiency == true then
    W_s_dot = theta_h * K_i_tr_dot;
  else
    W_s_dot = look_up_table.y[1] * K_i_tr_dot;
  end if;
  //// turbine pressures
  p_i_tr = i.p;
  p_o_tr = o.p;
  //// output mechanical power
  P_out = W_s_dot;
  //// for temperature variation, not finished...
  //i.T = o.T;
  ////
  annotation (
    Documentation(info= "<html><p>
This is a simple model of the turbine that give possibilities for simplified
modelling of the turbine unit. The model can use a constant efficiency or varying
efficiency from a lookup-table.
This model does not include any information about rotational speed of the runner.
</p>
<p>
This model is baseed on the energy balance and a simple valve-like expression.
The guide vane 'valve capacity' should be used for this valve-like expression and can either be specified
directly by the user by specifying <code>C_v</code> or it will be calculated from
the turbine nominal net head <code>H_n</code> and nominal flow rate
<code>V_dot_n</code>.
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
<img src=\"modelica://OpenHPL/Resources/Images/turbinepic.png\">
</p><h5>References</h5><p>More info about the model can be found in:&nbsp;<a href=\"Resources/Report/Report.docx\">Resources/Report/Report.docx</a></p>
</html>"),
    Icon(      coordinateSystem(initialScale = 0.1)));
end Turbine;
