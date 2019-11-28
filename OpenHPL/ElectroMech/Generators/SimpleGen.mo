within OpenHPL.ElectroMech.Generators;
model SimpleGen "Model of a simple generator"
  outer Data data "Using standard class with constants";
  import Modelica.Constants.pi;
  extends OpenHPL.Icons.Generator;
  //// geometrical parameters of the agreggate
  parameter Modelica.SIunits.MomentOfInertia J = 2e5 "Moment of inertia of the generator";
  parameter Modelica.SIunits.Efficiency theta_e = 0.99 "Generator's electrical efficiency";
  parameter Real k_b = 1000 "Friction factor in the aggregate bearing box [W-s3/rad3]";
  parameter Integer p = 12 "Number of poles";
  //// condition of steady state
  parameter Boolean SteadyState = data.Steady "If true - starts from Steady State" annotation (
    Dialog(group = "Initialization"));
  //// staedy state value for angular velocity
  parameter Modelica.SIunits.AngularVelocity w_0 = data.f * 4 * pi / p "Initial mechanical angular velocity" annotation (
    Dialog(group = "Initialization"));
  //// condition for output
  parameter Boolean UseFrequencyOutput = true "If checked - get a connector for frequency output" annotation (
    choices(checkBox = true));
  //// variables
  Modelica.SIunits.AngularVelocity w(start = w_0) "Mechanical angular velocity";
  Modelica.SIunits.Energy K_a "Kinetic energy";
  Modelica.SIunits.EnergyFlowRate Wdot_ts "Shaft power";
  Modelica.SIunits.EnergyFlowRate W_fa "Friction losses";
  Modelica.SIunits.EnergyFlowRate W_g = u / theta_e "Electrical power";
  //// conectors
  Modelica.Blocks.Interfaces.RealInput u "Electrical demand"    annotation (
    Placement(visible = true, transformation(extent={{-140,-20},{-100,20}},     rotation = 0), iconTransformation(extent = {{-120, -20}, {-80, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealOutput f= p/2 * w/(2*pi) if UseFrequencyOutput "Output of generator frequency"
                                                                                             annotation (
    Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P_in = Wdot_ts "Input of mechanical power" annotation (
    Placement(visible = true, transformation(origin={3.55271e-15,120},
                                                                  extent={{-20,-20},{20,20}},      rotation = 270)));
  Modelica.Blocks.Interfaces.RealOutput w_out = w "Output angular velocity of the generator"
                                                                                      annotation (
    Placement(visible = true, transformation(origin={110,60},    extent={{-10,-10},
            {10,10}},                                                                             rotation=0)));
initial equation
  if SteadyState == true then
    der(K_a) = 0;
  else
    w = w_0;
  end if;
equation
  //// generator energy balance
  K_a = 0.5 * J * w ^ 2;
  W_fa = 0.5 * k_b * w ^ 2;
  der(K_a) = Wdot_ts - W_fa - W_g;
  annotation (
    Documentation(info="<html><p>Simple model of an ideal generator with friction.</p>
<p>This model has inputs as electric power available on the grid and the turbine shaft power.
This model based on the angular momentum balance, which depends on the turbine shaft power,
 the friction loss in the aggregate rotation and the power taken up by the generator.</p>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/simplegen.png\">
</p>
</html>"));
end SimpleGen;
