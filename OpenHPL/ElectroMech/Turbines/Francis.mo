within OpenHPL.ElectroMech.Turbines;
model Francis "Model of the Francis turbine"
  outer Data data "Using standard class with constants";
    extends Icons.Turbine;
    import Modelica.Constants.pi;
    // conditions for the geometrical parameters of the turbine
    parameter Boolean GivenData = true "If checked the user specifies whole set of parameters. Otherwise, the design algorithm will be used for missed parameters" annotation (
        choices(checkBox = true),
        Dialog(group = "Given data"));
    parameter Boolean dp_v_condition = false "If checked then it includes the pressure drop through the guide vane (leave it unchecked - this doesn't work well)" annotation (
        choices(checkBox = true),
        Dialog(tab = "Guide vane"));
    parameter Boolean GivenServoData = true "If checked the user specifies parameters for the servo. Otherwise, the design algorithm will be used for missed parameters" annotation (
        choices(checkBox = true),
        Dialog(tab = "Servo"));
    // nominal parameters of the turbine
    parameter SI.Height H_n = 460 "Nominal head" annotation (
        Dialog(group = "Nominal parameters"));
    parameter SI.VolumeFlowRate Vdot_n = 24.3 "Nominal flow" annotation (
        Dialog(group = "Nominal parameters"));
    parameter SI.Power P_n = 103e6 "Nominal power" annotation (
        Dialog(group = "Nominal parameters"));
  parameter Modelica.Units.NonSI.AngularVelocity_rpm n_n=500 "Nominal turbine speed" annotation (Dialog(group="Nominal parameters"));
    // geometrical parameters of the turbine
    parameter SI.Radius R_1_ = 2.63 / 2 "Radius of the turbine blade inlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), R_2_ = 1.55 / 2 "Radius of the turbine blade outlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), R_v_ = 2.89 / 2 "Radius of the guide vane suspension circle" annotation (
        Dialog(tab = "Guide vane", enable = GivenData));
    parameter SI.Length w_1_ = 0.2 "Width of the turbine/blades inlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), w_v_ = w_1_ "Width of the guide vane suspension circle" annotation (
        Dialog(tab = "Guide vane", enable = GivenData)), r_v_ = 1.1 "Radius of servo circle" annotation (
        Dialog(tab = "Servo")), r_Y_ = 1.2 "Radius to servo connection" annotation (
        Dialog(tab = "Servo")), R_Y_ = 3 "Radius to servo" annotation (
        Dialog(tab = "Servo"));
    parameter SI.Diameter D_i = 1.632 "Diameter of the inlet pipe" annotation (
        Dialog(tab = "Guide vane", group = "Scroll case"));
    parameter Boolean Given_losses = true "Friction shock loss coefficient due to shock" annotation (
        choices(checkBox = true),
        Dialog(group = "Losses in runner"));
    parameter Real k_ft1_ = 7e5 "Friction shock loss coefficient due to shock" annotation (
        Dialog(group = "Losses in runner")), k_ft2_ = 0 "Hydraulic friction loss coefficient due to effluent whirl" annotation (
        Dialog(group = "Losses in runner")), k_ft3_ = 1.63e4 "Friction loss coefficient due to wall friction" annotation (
        Dialog(group = "Losses in runner")), k_fv = 0 "Friction loss coefficient from turbine entrance and across guide vanes" annotation (
        Dialog(tab = "Guide vane")), k_ft4 = k_ft3_ * 100 "Friction loss coefficient that is used for low load (under u_min)" annotation (
        Dialog(group = "Parameters for low load"));
    parameter Real u_min = 0.03 "Control signal value under which the moodel used k_f4 friction term to balance the model" annotation (
        Dialog(group = "Parameters for low load"));
  parameter Modelica.Units.NonSI.Angle_deg beta1_=110 "Turbine inlet blade angle" annotation (Dialog(group="Runner", enable=GivenData));
  parameter Modelica.Units.NonSI.Angle_deg beta2_=162.5 "Turbine outlet blade angle" annotation (Dialog(group="Runner", enable=GivenData));
    parameter Real Reduction = 0.2 "Reduction the given formula for the guide vane pressure drop" annotation (
        Dialog(tab = "Guide vane")), u_start_ = 2.28 "Servo position with zero flow" annotation (
        Dialog(tab = "Servo")), u_end_ = 2.4 "Servo position with full flow" annotation (
        Dialog(tab = "Servo"));
    // condition for the inlet water compressibility
    parameter Boolean WaterCompress = false "If checked the water is compressible in the penstock" annotation (
        choices(checkBox = true),
        Dialog(group = "Condition"));
    // variables
    SI.Pressure p_r1 "Runner inlet pressure", dp_tr "Turbine pressure drop", dp_r "Runner pressure drop", p_tr2 "Turbine outlet pressure", dp_v "Guide vane pressure drop";
    SI.Area A_1 "Runner inlet cross section", A_0 "Turbine inlet cross section", A_v "Guide vane cross section", A_2 "Runner outlet cross section";
    SI.EnergyFlowRate Wdot_s "Shaft power", Wdot_ft "Total runner losses", W_t1 "Euler first term", W_t2 "Euler second term", Wdot_ft_s "Shock losses", Wdot_ft_w "Whirl losses", Wdot_ft_l "Friction losses", Wdot_t "Total power";
    SI.VolumeFlowRate Vdot "Flow rate";
    SI.AngularVelocity w=w_in "Angular velocity";
    SI.Velocity u_2 "Outlet reference velocity", c_m2 "Outlet meridional velocity", c_m1 "Inlet meridional velocity", u_1 "Inlet reference velocity", c_u1 "Inlet tangential velocity";
  Modelica.Units.NonSI.Angle_deg beta1 "Inlet blade angle";
  Modelica.Units.NonSI.Angle_deg beta2 "Outlet blade angle";
  Modelica.Units.NonSI.Angle_deg _beta1;
    SI.Angle alpha1 "Inlet guide vane angle", phi "One of servo angles", psi "One of servo angles", theta "One of servo angles", dtheta "One of servo angles";
    Real k_ft1, k_ft2, k_ft3;
    //"Losses coefficients"
    Real cot_a1, cot_a2, cot_b1, cot_b2, cot_g1, sin_a1, coef;
    // cotants, cosines and sines of angles
    SI.Length l = 1.8 * sqrt((R_v - r_v) ^ 2 / 2) "Servo term", d "Servo term", R_1 "Inlet runner radius", R_2 "Outlet runner radius", R_v "Guide vane radius", w_1 "Inlet runner width/geight", w_v "Guide vane width/geight", r_Y "Servo term", R_Y "Servo term", r_v "Servo term";
    Real Y "Servo position", Y0 = sqrt(R_Y ^ 2 - r_Y ^ 2) "Initial servo position", theta0 = Modelica.Math.acos(r_Y / R_Y) "Initial servo angle";
    Real d0_2 = l * (r_v ^ 2 - R_v ^ 2) / (l - R_v) "Initial servo term d";
    Real theta_0 = theta0 - Modelica.Math.acos((r_v ^ 2 + R_v ^ 2 - d0_2) / (2 * r_v * R_v)) "Servo angle for fully close guide vane";
    Real u_end "Servo position for fully open guide vane", u_start "Servo position for fully close guide vane";
    Real W_t2_n "Euler second term, nominal", W_t1_n "Euler first term, nominal", Wdot_t_n "Total power, nominal", cot_a1_n "Cotant nominal alpha", Vdot_n_ = Vdot_n / 0.99 "Flow rate for fully open guide vane", d_n(start = 0.67) "Nominal servo term", theta_n "Servo angle for fully open guide vane";
    SI.Angle alpha1_n "Nominal inlet guide vane angle";
    // connectors
    extends OpenHPL.Interfaces.TurbineContacts;
    Modelica.Blocks.Interfaces.RealInput w_in "Input angular velocity from the generator" annotation (
                                Placement(transformation(origin={-120,-80}, extent={{-20,-20},
      {20,20}})));
equation
  // design algorithm for runner
    if GivenData then
        R_1 = R_1_;
        R_2 = R_2_;
        R_v = R_v_;
        w_1 = w_1_;
        w_v = w_v_;
        beta1 = beta1_;
        beta2 = beta2_;
        _beta1 = 180 - beta1;
    else
        beta2 = 162.5;
        R_2 =0.5*(240*Vdot_n/(pi^2*n_n*Modelica.Math.tan(Modelica.Units.Conversions.from_deg(180 - beta2))))^(1/3);
        R_1 = 30 * u_1 / pi / n_n;
        w_1 = 0.8 * Vdot_n / (pi * 2 * R_1 * c_m1);
        w_v = w_1;
        R_v = 1.1 * R_1;
    Modelica.Math.tan(Modelica.Units.Conversions.from_deg(_beta1)) = c_m1/(u_1 - c_u1);
        beta1 = 180 - _beta1;
    end if;
  // design algorithm for runner losses
    if Given_losses then
        k_ft1 = k_ft1_;
        k_ft2 = k_ft2_;
        k_ft3 = k_ft3_;
    else
        k_ft1 = 11.5e3 * exp(8.9e-3 * H_n);
        k_ft2 = 0;
        k_ft3 = 7e2 * exp(6.7e-3 * H_n);
    end if;
  // design algorithm for servo
    if GivenServoData then
        r_v = r_v_;
        r_Y = r_Y_;
        R_Y = R_Y_;
        u_start = u_start_;
        u_end = u_end_;
    else
        r_v = 0.75 * R_v;
        r_Y = 0.1 + r_v;
        R_Y = 1.8 + r_Y;
        u_start = sqrt(r_Y ^ 2 + R_Y ^ 2 - 2 * r_Y * R_Y * Modelica.Math.cos(theta_0));
        u_end = sqrt(r_Y ^ 2 + R_Y ^ 2 - 2 * r_Y * R_Y * Modelica.Math.cos(theta_n));
    //u_start+0.17;
    end if;
  // design algorithm for nominal alpha, used for servo design
    W_t2_n = data.rho * Vdot_n_ * n_n * pi / 30 * R_2 * (n_n * pi / 30 * R_2 + Vdot_n_ / A_2 * cot_b2);
    W_t1_n = data.rho * Vdot_n_ * n_n * pi / 30 * R_1 * Vdot_n_ / A_1 * cot_a1_n;
    data.rho * Vdot_n_ * H_n * data.g + 0.5 * data.rho * Vdot_n_ * Vdot_n_ ^ 2 * (1 / A_0 ^ 2 - 1 / A_2 ^ 2) = Wdot_t_n;
    Wdot_t_n = W_t1_n - W_t2_n + k_ft3 * Vdot_n_ ^ 2;
    alpha1_n = Modelica.Math.atan(1 / cot_a1_n);
    alpha1_n = Modelica.Math.acos(d_n / 2 / l) - Modelica.Math.acos((d_n ^ 2 + R_v ^ 2 - r_v ^ 2) / 2 / d_n / R_v);
    theta_n = theta0 - Modelica.Math.acos((r_v ^ 2 + R_v ^ 2 - d_n ^ 2) / (2 * r_v * R_v));
  // design algorithm for velocities, used for runner design
    u_2 = 2 * pi * R_2 * n_n / 60;
    c_m2 =u_2*Modelica.Math.tan(Modelica.Units.Conversions.from_deg(180 - beta2));
    c_m1 = c_m2 / 1.1;
    u_1 = 0.725 * sqrt(2 * data.g * H_n);
    c_u1 = 0.48 / 0.725 * sqrt(2 * data.g * H_n);
  // condition for inlet water compressability
    if not WaterCompress then
        Vdot = mdot / data.rho;
        dp_v = 0.5 * data.rho * (Vdot ^ 2 * (A_0 ^ 2 - A_v ^ 2 * sin_a1 ^ 2) / (A_0 ^ 2 * A_v ^ 2 * sin_a1 ^ 2) + k_fv) * Reduction;
    else
        Vdot = mdot / (data.rho * (1 + data.beta * (p_r1 - data.p_a)));
        dp_v = 0.5 * data.rho * (1 + data.beta * (i.p - data.p_a)) * (Vdot ^ 2 * (A_0 ^ 2 - A_v ^ 2 * sin_a1 ^ 2) / (A_0 ^ 2 * A_v ^ 2 * sin_a1 ^ 2) + k_fv) * Reduction;
    end if;
  // condition for guide vane pressure drop (does not work well, better to skip guide vane pressure drop)
    if dp_v_condition then
        p_r1 = i.p - dp_v;
        dp_tr = dp_r + dp_v;
    else
        p_r1 = i.p;
        dp_tr = dp_r;
    end if;
  // define areas
    sin_a1 = Modelica.Math.sin(alpha1);
    A_1 = 2 * R_1 * w_1 * pi;
    A_0 = D_i ^ 2 * pi / 4;
    A_v = 2 * R_v * w_v * pi;
    A_2 = R_2 ^ 2 * pi;
  // Euler equation for shaft power
    W_t1 = mdot * w * R_1 * Vdot / A_1 * cot_a1;
    W_t2 = mdot * w * R_2 * (w * R_2 + Vdot / A_2 * cot_b2);
    Wdot_s = W_t1 - W_t2;
  // condition for low load
    if u_t < u_min then
        Wdot_ft_s = 0;
        Wdot_ft_w = 0;
        Wdot_ft_l = k_ft4 * Vdot ^ 2;
    else
        Wdot_ft_s = k_ft1 * Vdot * (cot_g1 - cot_b1) ^ 2;
        Wdot_ft_w = k_ft2 * Vdot * cot_a2 ^ 2;
        Wdot_ft_l = k_ft3 * Vdot ^ 2;
    end if;
  // losses in the runner
    Wdot_ft = Wdot_ft_s + Wdot_ft_w + Wdot_ft_l;
  // servo model, define guide vane opening and alpha1
    Y = u_start + u_t * (u_end - u_start);
    Y ^ 2 = r_Y ^ 2 + R_Y ^ 2 - 2 * r_Y * R_Y * Modelica.Math.cos(theta);
    dtheta = theta - theta0;
    d ^ 2 = r_v ^ 2 + R_v ^ 2 - 2 * r_v * R_v * Modelica.Math.cos(dtheta);
    r_v ^ 2 = d ^ 2 + R_v ^ 2 - 2 * d * R_v * Modelica.Math.cos(psi);
    Modelica.Math.cos(phi) = d / 2 / l;
    alpha1 = phi - psi;
  // Blade angles relation
    cot_a1 = 1 / Modelica.Math.tan(alpha1);
    cot_a2 = cot_b2 + w * R_2 / (Vdot / A_2);
    cot_b1 =1/Modelica.Math.tan(Modelica.Units.Conversions.from_deg(beta1));
    cot_b2 =1/Modelica.Math.tan(Modelica.Units.Conversions.from_deg(beta2));
    cot_g1 = cot_a1 - w * R_1 / (Vdot / A_1);
  // pressure drop through the turbine
    dp_r * Vdot + 0.5 * mdot * Vdot ^ 2 * (1 / A_0 ^ 2 - 1 / A_2 ^ 2) = Wdot_t;
    Wdot_t = Wdot_s + Wdot_ft;
    dp_r = p_r1 - p_tr2;
  // turbine efficiency
    coef = Wdot_s / Wdot_t;
  // connectors
    p_tr2 = o.p;
  // output mechanical power
    P_out = Wdot_s;
    annotation (
        Documentation(info="<html>
<p>
This is the Francis turbine model that gives possibilities for proper modelling of the Francis turbine.
</p>
<p>The mechanistic model is based on Euler equations for the Francis turbine.
Besides hydraulic input and output, there are input as the control signal for the valve opening
and also output as the turbine shaft power and input as angular velocity.
</p>
<p align=\"center\">
<img src=\"modelica://OpenHPL/Resources/Images/turbinefrancis.svg\">
</p>
<p>There is also available the runner design algorithm that can define all geometrical
parameters based on the nominal parameters.</p><p>The turbine losses coefficients
(<code>k_ft1</code>, <code>k_ft2</code>, <code>k_ft3</code>) can be also defined automatically.
However, if some dynamic data from real turbine is available it is better to tune
these parameters a bit more and use the defined values as a starting point.
</p>
<p>A model for servo that that runs the guide vane opening is also available.
Furthermore it is possible to automatically generate all need parameters for the servo,
 or simply specify them.
</p>
<p>
This mechanistic turbine model does not work really well for low loads (&lt;10% guide vane opening).
However there is parameters that could be tuned for low load regimes.
These are <code>u_min</code> and <code>k_ft4</code>.</p>

<p>More info about the mechanistic turbine model can be found in:
<a href=\"modelica://OpenHPL.UsersGuide.References\">[Vytvytskyi2018]</a> and about
the servo (also turbine model) in:
<a href=\"modelica://OpenHPL/Resources/Documents/Turbines_model.pdf\">Resources/Documents/Turbines_model.pdf</a>.</p>
</html>"));
end Francis;
