within OpenHPLTest;

package EmpiricalTurbine
  extends Modelica.Icons.ExamplesPackage;

  class Information
  extends Modelica.Icons.Information;
    annotation(
      Documentation(info = "<html><head></head><body>The EmpiricalTurbine test package contains a series of test models for documeting and validating the implementation of the EmpiricalTurbine model.<div>There are two sub-packages:</div><div><ul><li>TestBasicFunctions - testing of the Bezier spline algorithm, the search algorithm and the blening function (to find intermediate curves)</li><li>TurbineTetst - collection of gradually more complex test cases using the EmpiricalTurbine model</li></ul>At the moment there are som robustness issues with the model. In the default configuration Test03_Turbine have issues with convergens at time t=0.34 with the message <pre>Homotopy solver Newton iteration: Maximum number of iterations reached at time 0.340000, but no root found.</pre> The following documents testing and investigations to resovle this.</div>In particular it is important to understand some of the following topics <ul><li><a href=\"https://openmodelica.org/doc/OpenModelicaUsersGuide/latest/solving.html\">Solving Modelica Models</a></li><li><a href=\"https://en.wikipedia.org/wiki/Homotopy_analysis_method\">Homotopy analysis method</a></li><li><a href=\"https://en.wikipedia.org/wiki/Stiff_equation\">Stiff equation</a></li> </ul>and how different implementations may impact the robustness of the models.<br/>Some observations:<ul><li>Turbine model with only upstream and downstream reservoir and constant opening works fine (Test02).</li><li>Turbine model with upstream and downstream reservoir and ramping opening works fine (Test04).</li><li>Turbine model with rigid water pipe and constant opening works shows clear convergence issues (Test03).</li></ul>Additional comments:<br/>In general convergence issues can either be related to \"stiff\" problems or singularities or discontinuous functions (or gradients). Running Test03 with the dassl solver, with startTime=0 and stopTime=1 and varying time step gives the following result.<br/><table border=\"1\"><thead><tr><th>Time step</th><th>Comments</th></tr></thead><tbody><tr><td>0.005</td><td>Convergence issues from t=0.26500 (nonlinear system 82)</td></tr><tr><td>0.01</td><td>Convergence issues from t=0.34000</td></tr><tr><td>0.02</td><td>Convergence issues from t=0.34000</td></tr><tr><td>0.05</td><td>Convergence issues from t=0.683162</td></tr><tr><td>0.10</td><td>Convergence issues from t=0.683162</td></tr><tr><td>0.20</td><td>Convergence issues from t=0.683162</td></tr></tbody></table><br/>Normally, for stiff problems, reducing the time step should improve the convergence. This seems not to be the case here.</body></html>"));
  end Information;

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
    
    partial model AbstractTurbineTest
      extends Modelica.Icons.Example;
       inner OpenHPL.Data data annotation(
        Placement(transformation(origin = {-84, 82}, extent = {{-10, -10}, {10, 10}})));
      protected
        constant Integer NC = 11;
        constant Integer NP = 6;
        constant Integer ND = 3;
        parameter Real openingArray[NC] = {0.014, 0.030, 0.050, 0.100, 0.200, 0.300, 0.400, 0.500, 0.601, 0.800, 1.000};
        parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.07, 0.07}, {0.30, 0.10, 0.07}, {0.54, -0.07, -0.03}, {0.92, 0.25, 0.13}, {1.13, -0.11, -0.17}, {1.43, -0.06, -0.31}}, {{0.00, 0.11, 0.15}, {0.32, 0.15, 0.17}, {0.51, -0.06, -0.09}, {1.00, 0.35, 0.35}, {1.11, -0.12, -0.30}, {1.43, -0.09, -0.31}}, {{0.00, 0.15, 0.23}, {0.34, 0.21, 0.24}, {0.47, -0.08, -0.01}, {1.07, 0.46, 0.35}, {1.09, -0.15, -0.24}, {1.43, -0.11, -0.37}}, {{0.00, 0.27, 0.45}, {0.37, 0.30, 0.40}, {0.40, 0.05, 0.30}, {1.38, 0.60, 0.26}, {0.97, -0.19, -0.17}, {1.43, -0.13, -0.42}}, {{0.00, 0.51, 0.92}, {0.40, 0.53, 0.80}, {0.45, 0.31, 0.83}, {1.48, 0.75, 0.14}, {0.99, -0.14, -0.06}, {1.44, -0.17, -0.49}}, {{0.00, 0.77, 1.41}, {0.44, 0.79, 1.23}, {0.51, 0.56, 1.29}, {1.62, 0.82, -0.14}, {0.99, -0.05, 0.11}, {1.43, -0.18, -0.51}}, {{0.00, 1.01, 1.87}, {0.48, 1.05, 1.70}, {0.56, 0.74, 1.46}, {1.68, 0.84, -0.35}, {1.03, 0.06, 0.23}, {1.43, -0.19, -0.53}}, {{0.00, 1.25, 2.27}, {0.52, 1.26, 1.99}, {0.63, 1.00, 1.84}, {1.70, 0.83, -0.64}, {1.08, 0.17, 0.35}, {1.43, -0.18, -0.52}}, {{0.00, 1.46, 2.60}, {0.53, 1.45, 2.33}, {0.77, 1.19, 1.80}, {1.63, 0.86, -0.58}, {1.13, 0.24, 0.31}, {1.43, -0.17, -0.52}}, {{0.00, 1.79, 3.06}, {0.55, 1.78, 2.77}, {0.99, 1.43, 1.67}, {1.53, 0.94, -0.59}, {1.20, 0.31, 0.28}, {1.45, -0.16, -0.54}}, {{0.00, 2.10, 3.41}, {0.59, 2.02, 2.99}, {1.05, 1.63, 1.56}, {1.53, 1.04, -0.47}, {1.22, 0.40, 0.24}, {1.45, -0.13, -0.54}}};
        /*
        constant Integer NC = 5;
      constant Integer NP = 4;
      constant Integer ND = 3;
      parameter Real openingArray[NC] = {0.10, 0.25, 0.50, 0.75, 1.00};
      parameter Real controlPoints[NC, NP, ND] = {{{0.00, 0.18, 0.26}, {0.41, 0.10, 0.17}, {1.04, 0.31, 0.25}, {1.32, -0.04, -0.21}}, {{0.00, 0.44, 0.73}, {0.43, 0.37, 0.67}, {1.27, 0.55, 0.29}, {1.38, 0.00, -0.19}}, {{0.00, 0.91, 1.55}, {0.59, 0.89, 1.33}, {1.57, 0.79, 0.19}, {1.51, 0.00, -0.29}}, {{0.00, 1.30, 2.11}, {0.78, 1.33, 1.77}, {1.72, 0.92, -0.12}, {1.58, 0.00, -0.28}}, {{0.00, 1.57, 2.41}, {0.92, 1.63, 1.91}, {1.82, 1.02, -0.30}, {1.63, 0.00, -0.35}}};
        */
        parameter OpenHPL.Types.TurbineCharacteristics tc(nCurves = NC, nPoints = NP, nDim = ND, opening = openingArray, data = controlPoints);
        public
        parameter OpenHPL.Types.TurbineData turbineData(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = data.g, rho = data.rho) annotation(
        Placement(transformation(origin = {-82, 54}, extent = {{-10, -10}, {10, 10}})));
      
        
   end AbstractTurbineTest;

    model Test01_TurbineLookUp
      extends AbstractTurbineTest;
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
      (Qt, Tt) = OpenHPL.Functions.TurbineLookUp(Ht, nrps, opening, turbineData, tc);
      annotation(
        experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.001),
        Documentation(info = "<html><head></head><body>Basic test of &nbsp;the turbine lookup function. The head is kept constant, the speed is a linear function of time, and the flow and torque is computed from the model.<div>Running the model the turbine flow Qt or turbine torque Tt can be ploted as function of time.</div></body></html>"));
    end Test01_TurbineLookUp;

    //

    model Test02_Turbine
    extends AbstractTurbineTest;
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
    end Test02_Turbine;

    //

    model Test03_Turbine
       extends AbstractTurbineTest;
    
      public
      OpenHPL.Waterway.Pipe tunnel(H = 0, L = 2000, p_eps_input(displayUnit = "mm") = 1e-4, D_i = 4.6, SteadyState = true, Vdot_0 = 20.5) annotation(
        Placement(transformation(origin = {-44, 32}, extent = {{-10, -10}, {10, 10}})));
      
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
        experiment(StartTime = 0, StopTime = 10.0, Tolerance = 1e-06, Interval = 0.2000),
        Documentation(info = "<html><head></head><body>Generic test with penstock and emprical turbine model. The opening is kept fixed and the unit is allowed to speed up to runaway.</body></html>"),
  __OpenModelica_commandLineOptions = "--matchingAlgorithm=PFPlusExt --indexReductionMethod=dynamicStateSelection -d=initialization,NLSanalyticJacobian",
  __OpenModelica_simulationFlags(lv = "LOG_STDOUT,LOG_ASSERT,LOG_STATS", s = "dassl", noHomotopyOnFirstTry = "()",homMaxNewtonSteps= "50",homMaxTries="30",variableFilter = ".*"));
    end Test03_Turbine;

    //

    model Test04_Turbine
       extends AbstractTurbineTest;
       public
      OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation(
        Placement(transformation(origin = {-46, 28}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation(
        Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = false, f_0 = 1.0, enable_f = true) annotation(
        Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Sources.Ramp ramp(height = -1, duration = 10, offset = 1, startTime = 2) annotation(
        Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      parameter OpenHPL.Types.TurbineData turbineData(Dn = 1.59, nrps = 8.33, Hbep = 425.0, Qbep = 23.95, Tbep = 1.718E+06, openingBep = 0.601, g = data.g, rho = data.rho) annotation(
        Placement(transformation(origin = {-80, 44}, extent = {{-12, 24}, {6, 6}})));
    equation
      connect(overvann.o, turbine.i) annotation(
        Line(points = {{-36, 28}, {-20, 28}, {-20, 12}, {2, 12}}, color = {0, 128, 255}));
      connect(turbine.o, undervann.o) annotation(
        Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
      connect(ramp.y, turbine.u_t) annotation(
        Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
    annotation(
        experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.01));
end Test04_Turbine;
    //
    model Test05_Turbine
      extends AbstractTurbineTest;
      //
      public
      OpenHPL.Waterway.Reservoir overvann(h_0 = 425.0, constantLevel = true) annotation(
        Placement(transformation(origin = {-82, 12}, extent = {{-10, -10}, {10, 10}})));
      OpenHPL.Waterway.Reservoir undervann(h_0 = 0.0, constantLevel = true) annotation(
        Placement(transformation(origin = {72, -16}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
      OpenHPL.ElectroMech.Turbines.EmpiricalTurbine turbine(turbineData = turbineData, turbineCharacteristics = tc, SteadyState = false, enable_nomSpeed = true) annotation(
        Placement(transformation(origin = {12, 12}, extent = {{-10, -10}, {10, 10}})));
       OpenHPL.Waterway.Pipe tunnel(H = 0, L = 2000, p_eps_input(displayUnit = "mm") = 1e-4, D_i = 4.6, SteadyState = true, Vdot_0 = 20.5) annotation(
          Placement(transformation(origin = {-42, 12}, extent = {{-10, -10}, {10, 10}})));
        
      Modelica.Blocks.Sources.Ramp ramp(height = 1, duration = 10, offset = 0, startTime = 0.1) annotation(
        Placement(transformation(origin = {52, 72}, extent = {{10, -10}, {-10, 10}}, rotation = -0)));
    equation
      connect(turbine.o, undervann.o) annotation(
        Line(points = {{22, 12}, {28, 12}, {28, -16}, {62, -16}}, color = {0, 128, 255}));
      connect(ramp.y, turbine.u_t) annotation(
        Line(points = {{41, 72}, {4, 72}, {4, 24}}, color = {0, 0, 127}));
    connect(overvann.o, tunnel.i) annotation(
        Line(points = {{-72, 12}, {-52, 12}}, color = {0, 128, 255}));
    connect(tunnel.o, turbine.i) annotation(
        Line(points = {{-32, 12}, {2, 12}}, color = {0, 128, 255}));
    end Test05_Turbine;
  end TurbineTest;
end EmpiricalTurbine;
