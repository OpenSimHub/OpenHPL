within OpenHPLTest;

package EmpiricalTurbine
  extends Modelica.Icons.ExamplesPackage;

  package TestBasicFunctions
    extends Modelica.Icons.ExamplesPackage;
    //

    model Test01_BezierCurve
      extends Modelica.Icons.Example;
      Real[ndim] curvePoint;
    protected
      constant Integer ndim = 3;
      parameter Real controlPoints[6, ndim] = {{0.00, 1.46, 2.60}, {0.53, 1.45, 2.33}, {0.77, 1.19, 1.80}, {1.63, 0.86, -0.58}, {1.13, 0.24, 0.31}, {1.43, -0.17, -0.52}};
    equation
      curvePoint = OpenHPL.Functions.deCasteljau(time, ndim, controlPoints);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
        Documentation(info = "<html><head></head><body>Basic test of evaluation of Bezier curve using deCasteljau algorithm.<div>Parametric curve plot of curvePoint[1] againts curvPoint[2] should show a smooth trajectory of QED vs nED.<br><div><br></div><div><br></div></div></body></html>"));
    end Test01_BezierCurve;

    //

    model Test02_ControlPoints
      extends Modelica.Icons.Example;
      //
    protected
      constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
      parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
    public
      Real cPoints1[NP, ND], cPoints2[NP, ND], cPoints3[NP, ND];
      Real[ND] curvePoint1, curvePoint2, curvePoint3;
    equation
      cPoints1 = OpenHPL.Functions.WeightedControlPoints(0.3, tc);
      curvePoint1 = OpenHPL.Functions.deCasteljau(time, ND, cPoints1);
      cPoints2 = OpenHPL.Functions.WeightedControlPoints(0.5, tc);
      curvePoint2 = OpenHPL.Functions.deCasteljau(time, ND, cPoints2);
      cPoints3 = OpenHPL.Functions.WeightedControlPoints(0.67, tc);
      curvePoint3 = OpenHPL.Functions.deCasteljau(time, ND, cPoints3);
      annotation(
        Documentation(info = "<html><head></head><body>Test basic functions for finding intermediate control points and evaluate Bezier curve.<div>Computes three curve trajectories as weighted intermediate curves. Parametrci curve plot of curvePoints1[1] against &nbsp;curvePoints1[2] and similar for curvePonts2 and curvePoints3 should show smooth curves 2D curves.</div></body></html>"),
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
    end Test02_ControlPoints;
  end TestBasicFunctions;

  package TurbineTest
    extends Modelica.Icons.ExamplesPackage;
    import SI = Modelica.Units.SI;

    model Test01_TurbineLookUp
      extends Modelica.Icons.Example;
    protected
      constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
      parameter OpenHPL.Types.TurbineData td(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = 9.81, rho = 997.0);
      parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
    public
    public
      Real opening;
      SI.Length Ht "Turbine head";
      SI.VolumeFlowRate Qt "Turbine flow rate";
      SI.Frequency nrps "Rotational speed";
      SI.Torque Tt "Turbine torque";
    equation
      Ht = 425.0;
      nrps = 1.0e-03 + 8.33*time*1.4;
      opening = 0.6;
      (Qt, Tt) = OpenHPL.Functions.TurbineLookUp(Ht, nrps, opening, td, tc);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
        Documentation(info = "<html><head></head><body>Basic test of &nbsp;the turbine lookup function. The head is kept constant, the speed is a linear function of time, and the flow and torque is computed from the model.<div>Running the model the turbine flow Qt or turbine torque Tt can be ploted as function of time.</div></body></html>"));
    end Test01_TurbineLookUp;

    //

    model Test02_Turbin
      extends Modelica.Icons.Example;
      inner OpenHPL.Data data annotation(
        Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
    protected
      constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
      parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
    public
      parameter OpenHPL.Types.TurbineData turbineData(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = data.g, rho = data.rho) annotation(
        Placement(transformation(origin = {-82, 54}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation(
        Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation(
        Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = false, f_0 = 0.2, enable_f = true) annotation(
        Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant const(k = 0.603) annotation(
        Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    equation
      connect(overvann.o, turbine.i) annotation(
        Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
      connect(turbine.o, undervann.o) annotation(
        Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
      connect(const.y, turbine.u_t) annotation(
        Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
      annotation(
        Documentation(info = "<html><head></head><body>Basic test of EpiricalTurbine model. Opening is kept constant.<div>Initial speed f_0 is set to 0.2 and the turbine is permitted to speed up as function of computed turbine torque Tt.<br><div><br></div></div></body></html>"),
        experiment(StartTime = 0, StopTime = 20, Tolerance = 1e-06, Interval = 0.001));
    end Test02_Turbin;

    //

    model Test03_Turbin
      extends Modelica.Icons.Example;
      inner OpenHPL.Data data annotation(
        Placement(transformation(origin = {-46, 62}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Pipe tunnel(H = 0, L = 2000, p_eps_input(displayUnit = "mm") = 1e-4, D_i = 4.6, SteadyState = true, Vdot_0 = 20.5) annotation(
        Placement(transformation(origin = {-44, 32}, extent = {{-10, -10}, {10, 10}})));
      parameter OpenHPL.Types.TurbineData turbineData(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = data.g, rho = data.rho) annotation(
        Placement(transformation(origin = {-82, 62}, extent = {{-10, -10}, {10, 10}})));
    protected
      constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
      parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
      public
      
      OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation(
        Placement(transformation(origin = {-80, 32}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation(
        Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = false, enable_f = true, f_0 = 0.2) annotation(
        Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Constant const(k = 0.603) annotation(
        Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    equation
      connect(turbine.o, undervann.o) annotation(
        Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
      connect(const.y, turbine.u_t) annotation(
        Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
      connect(overvann.o, tunnel.i) annotation(
        Line(points = {{-70, 32}, {-54, 32}}, color = {0, 128, 255}));
      connect(tunnel.o, turbine.i) annotation(
        Line(points = {{-34, 32}, {-24, 32}, {-24, 12}, {2, 12}}, color = {0, 128, 255}));
      annotation(
        experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.01),
        Documentation(info = "<html><head></head><body>Generic test with penstock and emprical turbine model. The opening is kept fixed and the unit is allowed to speed up to runaway.</body></html>"));
    end Test03_Turbin;

    //

    model Test04_Turbin
      extends Modelica.Icons.Example;
      inner OpenHPL.Data data annotation(
        Placement(transformation(origin = {-46, 62}, extent = {{-10, -10}, {10, 10}})));
    protected
      constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
      parameter OpenHPL.Types.TurbineData td(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = 9.81, rho = 997.0);
      parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
    public
      OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation(
        Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation(
        Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = td, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = true) annotation(
        Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 0.1) annotation(
        Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    equation
      connect(overvann.o, turbine.i) annotation(
        Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
      connect(turbine.o, undervann.o) annotation(
        Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
      connect(ramp.y, turbine.u_t) annotation(
        Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
    end Test04_Turbin;
  end TurbineTest;
end EmpiricalTurbine;
