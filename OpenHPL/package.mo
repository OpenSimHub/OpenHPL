package OpenHPL
  extends Icons.Logo;
  import C = Modelica.Constants;
  import SI = Modelica.SIunits;

  annotation (
    version="1.2.2",
    versionDate="2020-11-06",
    Protection(access = Access.packageDuplicate),
    uses(OpenIPSL(version="2.0.0-dev"), Modelica(version="3.2.3"),
    ModelicaTableAdditions(version="1.0.0")),
    preferredView="info",
    Documentation(info="<html>
<p>The OpenHPL is an open-source hydropower library that
consists of hydropower unit models and is modelled using Modelica.</p>
<p>It is developed at the <a href=\"https://www.usn.no/english\">University of South-Eastern Norway (USN)</a>, Campus Porsgrunn. </p>
<p>For more information see the <a href=\"modelica://OpenHPL.UsersGuide\">User's Guide</a>.</p>
</html>"));
end OpenHPL;
