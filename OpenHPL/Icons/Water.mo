within OpenHPL.Icons;
partial package Water "Hydro icon"
  extends Modelica.Icons.Package;

  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, grid={2,2}),           graphics={
        Line(
          points={{-60,-40},{-40,-52},{-20,-32},{0,-52},{20,-32},{40,-52},{60,-40}},
          color={28,108,200},
          smooth=Smooth.Bezier),
        Line(
          points={{-60,0},{-40,-12},{-20,8},{0,-12},{20,8},{40,-12},{60,0}},
          color={28,108,200},
          smooth=Smooth.Bezier),
        Line(
          points={{-60,40},{-40,28},{-20,48},{0,28},{20,48},{40,28},{60,40}},
          color={28,108,200},
          smooth=Smooth.Bezier)}),
    Diagram(coordinateSystem(preserveAspectRatio=false, grid={2,2})));
end Water;
