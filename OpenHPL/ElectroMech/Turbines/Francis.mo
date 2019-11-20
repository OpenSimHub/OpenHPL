within OpenHPL.ElectroMech.Turbines;
model Francis "Model of the Francis turbine"
  outer Parameters Const "using standard class with constants";
    extends Icons.Turbine;
    import Modelica.Constants.pi;
    //// conditions for the geometrical parameters of the turbine
    parameter Boolean GivenData = true "If checked the user specifies whole set of parameters. Otherwise, the design algorithm will be used for missed parameters" annotation (
        choices(checkBox = true),
        Dialog(group = "Given data"));
    parameter Boolean dp_v_condition = false "If checked then it includes the pressure drop through the guide vane (leave it unchecked - this doesn't work well)" annotation (
        choices(checkBox = true),
        Dialog(tab = "Guide vane"));
    parameter Boolean GivenServoData = true "If checked the user specifies parameters for the servo. Otherwise, the design algorithm will be used for missed parameters" annotation (
        choices(checkBox = true),
        Dialog(tab = "Servo"));
    //// nominal parameters of the turbine
    parameter Modelica.SIunits.Height H_n = 460 "Nominal head" annotation (
        Dialog(group = "Nominal parameters"));
    parameter Modelica.SIunits.VolumeFlowRate V_dot_n = 24.3 "Nominal flow" annotation (
        Dialog(group = "Nominal parameters"));
    parameter Modelica.SIunits.Power P_n = 103e6 "Nominal power" annotation (
        Dialog(group = "Nominal parameters"));
    parameter Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm n_n = 500 "Nominal turbine speed" annotation (
        Dialog(group = "Nominal parameters"));
    //// geometrical parameters of the turbine
    parameter Modelica.SIunits.Radius R_1_ = 2.63 / 2 "Radius of the turbine blade inlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), R_2_ = 1.55 / 2 "Radius of the turbine blade outlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), R_v_ = 2.89 / 2 "Radius of the guide vane suspension circle" annotation (
        Dialog(tab = "Guide vane", enable = GivenData));
    parameter Modelica.SIunits.Length w_1_ = 0.2 "Width of the turbine/blades inlet" annotation (
        Dialog(group = "Runner", enable = GivenData)), w_v_ = w_1_ "Width of the guide vane suspension circle" annotation (
        Dialog(tab = "Guide vane", enable = GivenData)), r_v_ = 1.1 "Radius of servo circle" annotation (
        Dialog(tab = "Servo")), r_Y_ = 1.2 "Radius to servo connection" annotation (
        Dialog(tab = "Servo")), R_Y_ = 3 "Radius to servo" annotation (
        Dialog(tab = "Servo"));
    parameter Modelica.SIunits.Diameter D_i = 1.632 "Diameter of the inlet pipe" annotation (
        Dialog(tab = "Guide vane", group = "Scroll case"));
    parameter Boolean Given_losses = true "Friction shock loss coefficient due to shock" annotation (
        choices(checkBox = true),
        Dialog(group = "Losses in runner"));
    parameter Real k_ft1_ = 7e5 "Friction shock loss coefficient due to shock" annotation (
        Dialog(group = "Losses in runner")), k_ft2_ = 0 "hydraulic friction loss coefficient due to effluent whirl" annotation (
        Dialog(group = "Losses in runner")), k_ft3_ = 1.63e4 "friction loss coefficient due to wall friction" annotation (
        Dialog(group = "Losses in runner")), k_fv = 0 "friction loss coefficient from turbine entrance and across guide vanes" annotation (
        Dialog(tab = "Guide vane")), k_ft4 = k_ft3_ * 100 "friction loss coefficient that is used for low load (under u_min)" annotation (
        Dialog(group = "Parameters for low load"));
    parameter Real u_min = 0.03 "control signal value under which the moodel used k_f4 friction term to balance the model" annotation (
        Dialog(group = "Parameters for low load"));
    parameter Modelica.SIunits.Conversions.NonSIunits.Angle_deg beta1_ = 110 "Turbine inlet blade angle" annotation (
        Dialog(group = "Runner", enable = GivenData)), beta2_ = 162.5 "Turbine outlet blade angle" annotation (
        Dialog(group = "Runner", enable = GivenData));
    parameter Real Reduction = 0.2 "reduction the given formula for the guide vane pressure drop" annotation (
        Dialog(tab = "Guide vane")), u_start_ = 2.28 "Servo position with zero flow" annotation (
        Dialog(tab = "Servo")), u_end_ = 2.4 "Servo position with full flow" annotation (
        Dialog(tab = "Servo"));
    //// condition for the inlet water compressibility
    parameter Boolean WaterCompress = false "If checked the water is compressible in the penstock" annotation (
        choices(checkBox = true),
        Dialog(group = "Condition"));
    //// variables
    Modelica.SIunits.Pressure p_r1 "runner inlet pressure", dp_tr "turbine pressure drop", dp_r "runner pressure drop", p_tr2 "turbine outlet pressure", dp_v "guide vane pressure drop";
    Modelica.SIunits.Area A_1 "runner inlet croos section", A_0 "turbine inlet croos section", A_v "guide vane croos section", A_2 "runner outlet croos section";
    Modelica.SIunits.EnergyFlowRate W_s_dot "shaft power", W_ft_dot "total runner losses", W_t1 "Euler first term", W_t2 "Euler second term", W_ft_dot_s "shock losses", W_ft_dot_w "whirl losses", W_ft_dot_l "friction losses", W_t_dot "total power";
    Modelica.SIunits.VolumeFlowRate V_dot "flow rate";
    Modelica.SIunits.AngularVelocity w "angular velocity";
    Modelica.SIunits.Velocity u_2 "outlet reference velocity", c_m2 "outlet meridional velocity", c_m1 "inlet meridional velocity", u_1 "inlet reference velocity", c_u1 "inlet tangential velocity";
    Modelica.SIunits.Conversions.NonSIunits.Angle_deg beta1 "inlet blade angle", beta2 "outlet blade angle", _beta1;
    Modelica.SIunits.Angle alpha1 "inlet guide vane angle", phi "one of servo angles", psi "one of servo angles", theta "one of servo angles", dtheta "one of servo angles";
    Real k_ft1, k_ft2, k_ft3;
    //"losses coefficients"
    Real cot_a1, cot_a2, cot_b1, cot_b2, cot_g1, sin_a1, coef;
    // cotants, cosines and sines of angles
    Modelica.SIunits.Length l = 1.8 * sqrt((R_v - r_v) ^ 2 / 2) "servo term", d "servo term", R_1 "inlet runner radius", R_2 "outlet runner radius", R_v "gude vane radius", w_1 "inlet runner width/geight", w_v "guide vane width/geight", r_Y "servo term", R_Y "servo term", r_v "servo term";
    Real Y "servo position", Y0 = sqrt(R_Y ^ 2 - r_Y ^ 2) "initial servo position", theta0 = Modelica.Math.acos(r_Y / R_Y) "initial servo angle";
    Real d0_2 = l * (r_v ^ 2 - R_v ^ 2) / (l - R_v) "initial servo term d";
    Real theta_0 = theta0 - Modelica.Math.acos((r_v ^ 2 + R_v ^ 2 - d0_2) / (2 * r_v * R_v)) "servo angle for fully close guide vane";
    Real u_end "servo position for fully open guide vane", u_start "servo position for fully close guide vane";
    Real W_t2_n "Euler second term, nominal", W_t1_n "Euler first term, nominal", W_t_dot_n "total power, nominal", cot_a1_n "cotant nominal alpha", V_dot_n_ = V_dot_n / 0.99 "flow rate for fully open guide vane", d_n(start = 0.67) "nominal servo term", theta_n "servo angle for fully open guide vane";
    Modelica.SIunits.Angle alpha1_n "nominal inlet guide vane angle";
    //// conectors
    extends OpenHPL.Interfaces.TurbineContacts;
    Modelica.Blocks.Interfaces.RealInput w_in = w "Input angular velocity from the generator" annotation (
                                Placement(visible = true, transformation(origin={-120,-80},    extent={{-20,-20},
      {20,20}},                                                                                                                 rotation = 0)));
equation
  //// design algorithm for runner
    if GivenData == true then
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
        R_2 = 0.5 * (240 * V_dot_n / (pi ^ 2 * n_n * Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(180 - beta2)))) ^ (1 / 3);
        R_1 = 30 * u_1 / pi / n_n;
        w_1 = 0.8 * V_dot_n / (pi * 2 * R_1 * c_m1);
        w_v = w_1;
        R_v = 1.1 * R_1;
        Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(_beta1)) = c_m1 / (u_1 - c_u1);
        beta1 = 180 - _beta1;
    end if;
  //// design algorithm for runner losses
    if Given_losses == true then
        k_ft1 = k_ft1_;
        k_ft2 = k_ft2_;
        k_ft3 = k_ft3_;
    else
        k_ft1 = 11.5e3 * exp(8.9e-3 * H_n);
        k_ft2 = 0;
        k_ft3 = 7e2 * exp(6.7e-3 * H_n);
    end if;
  //// design algorithm for servo
    if GivenServoData == true then
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
  //// design algorithm for nominal alpha, used for servo design
    W_t2_n = Const.rho * V_dot_n_ * n_n * pi / 30 * R_2 * (n_n * pi / 30 * R_2 + V_dot_n_ / A_2 * cot_b2);
    W_t1_n = Const.rho * V_dot_n_ * n_n * pi / 30 * R_1 * V_dot_n_ / A_1 * cot_a1_n;
    Const.rho * V_dot_n_ * H_n * Const.g + 0.5 * Const.rho * V_dot_n_ * V_dot_n_ ^ 2 * (1 / A_0 ^ 2 - 1 / A_2 ^ 2) = W_t_dot_n;
    W_t_dot_n = W_t1_n - W_t2_n + k_ft3 * V_dot_n_ ^ 2;
    alpha1_n = Modelica.Math.atan(1 / cot_a1_n);
    alpha1_n = Modelica.Math.acos(d_n / 2 / l) - Modelica.Math.acos((d_n ^ 2 + R_v ^ 2 - r_v ^ 2) / 2 / d_n / R_v);
    theta_n = theta0 - Modelica.Math.acos((r_v ^ 2 + R_v ^ 2 - d_n ^ 2) / (2 * r_v * R_v));
  //// design algorithm for velocities, used for runner design
    u_2 = 2 * pi * R_2 * n_n / 60;
    c_m2 = u_2 * Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(180 - beta2));
    c_m1 = c_m2 / 1.1;
    u_1 = 0.725 * sqrt(2 * Const.g * H_n);
    c_u1 = 0.48 / 0.725 * sqrt(2 * Const.g * H_n);
  //// condition for inlet water compressability
    if WaterCompress == false then
        V_dot = m_dot / Const.rho;
        dp_v = 0.5 * Const.rho * (V_dot ^ 2 * (A_0 ^ 2 - A_v ^ 2 * sin_a1 ^ 2) / (A_0 ^ 2 * A_v ^ 2 * sin_a1 ^ 2) + k_fv) * Reduction;
    else
        V_dot = m_dot / (Const.rho * (1 + Const.beta * (p_r1 - Const.p_a)));
        dp_v = 0.5 * Const.rho * (1 + Const.beta * (i.p - Const.p_a)) * (V_dot ^ 2 * (A_0 ^ 2 - A_v ^ 2 * sin_a1 ^ 2) / (A_0 ^ 2 * A_v ^ 2 * sin_a1 ^ 2) + k_fv) * Reduction;
    end if;
  //// condition for guide vane pressure drop (does not work well, better to skip guide vane pressure drop)
    if dp_v_condition == true then
        p_r1 = i.p - dp_v;
        dp_tr = dp_r + dp_v;
    else
        p_r1 = i.p;
        dp_tr = dp_r;
    end if;
  //// define areas
    sin_a1 = Modelica.Math.sin(alpha1);
    A_1 = 2 * R_1 * w_1 * pi;
    A_0 = D_i ^ 2 * pi / 4;
    A_v = 2 * R_v * w_v * pi;
    A_2 = R_2 ^ 2 * pi;
  //// Euler equation for shaft power
    W_t1 = m_dot * w * R_1 * V_dot / A_1 * cot_a1;
    W_t2 = m_dot * w * R_2 * (w * R_2 + V_dot / A_2 * cot_b2);
    W_s_dot = W_t1 - W_t2;
  //// condition for low load
    if u_t < u_min then
        W_ft_dot_s = 0;
        W_ft_dot_w = 0;
        W_ft_dot_l = k_ft4 * V_dot ^ 2;
    else
        W_ft_dot_s = k_ft1 * V_dot * (cot_g1 - cot_b1) ^ 2;
        W_ft_dot_w = k_ft2 * V_dot * cot_a2 ^ 2;
        W_ft_dot_l = k_ft3 * V_dot ^ 2;
    end if;
  //// losses in the runner
    W_ft_dot = W_ft_dot_s + W_ft_dot_w + W_ft_dot_l;
  //// servo model, define guide vane opening and alpha1
    Y = u_start + u_t * (u_end - u_start);
    Y ^ 2 = r_Y ^ 2 + R_Y ^ 2 - 2 * r_Y * R_Y * Modelica.Math.cos(theta);
    dtheta = theta - theta0;
    d ^ 2 = r_v ^ 2 + R_v ^ 2 - 2 * r_v * R_v * Modelica.Math.cos(dtheta);
    r_v ^ 2 = d ^ 2 + R_v ^ 2 - 2 * d * R_v * Modelica.Math.cos(psi);
    Modelica.Math.cos(phi) = d / 2 / l;
    alpha1 = phi - psi;
  //// Blade angles relation
    cot_a1 = 1 / Modelica.Math.tan(alpha1);
    cot_a2 = cot_b2 + w * R_2 / (V_dot / A_2);
    cot_b1 = 1 / Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(beta1));
    cot_b2 = 1 / Modelica.Math.tan(Modelica.SIunits.Conversions.from_deg(beta2));
    cot_g1 = cot_a1 - w * R_1 / (V_dot / A_1);
  //// pressure drop through the turbine
    dp_r * V_dot + 0.5 * m_dot * V_dot ^ 2 * (1 / A_0 ^ 2 - 1 / A_2 ^ 2) = W_t_dot;
    W_t_dot = W_s_dot + W_ft_dot;
    dp_r = p_r1 - p_tr2;
  //// turbine efficiency
    coef = W_s_dot / W_t_dot;
  //// conectors
    p_tr2 = o.p;
  //// output mechanical power
    P_out = W_s_dot;
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
(<i>k_ft1</i>, <i>k_ft2</i>, <i>k_ft3</i>) can be also defined automatically.
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
These are <i>u_min</i> and <i>k_ft4</i>.</p>
<h5>References</h5>
<p>More info about the mechanistic turbine model can be found in: <a href=\"https://www.sciencedirect.com/science/article/pii/S2405896318300181\">https://www.sciencedirect.com/science/article/pii/S2405896318300181</a></p>
<p>More info about the servo (also turbine model) can be found in: <a href=\"modelica://OpenHPL/Resources/Report/Turbines_model.pdf\">Resources/Report/Turbines_model.pdf</a></p>
</html>"),
        Icon(                                                                                                                                                      coordinateSystem(initialScale = 0.1)));
end Francis;
