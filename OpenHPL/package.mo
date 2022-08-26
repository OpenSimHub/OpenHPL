package OpenHPL "Open-source hydropower library"
  extends Icons.Logo;
  import C = Modelica.Constants;
  import      Modelica.Units.SI;

  annotation (
    version="2.0.0-dev",
    versionDate="2022-05-24",
    Protection(access = Access.packageDuplicate),
    uses(OpenIPSL(version="3.0.1"), Modelica(version="4.0.0")),
    preferredView="info",
    Documentation(info="<html>
<p>The OpenHPL is an open-source hydropower library that
consists of hydropower unit models and is modelled using Modelica.</p>
<p>It is developed at the <a href=\"https://www.usn.no/english\">University of South-Eastern Norway (USN)</a>, Campus Porsgrunn. </p>
<p>For more information see the <a href=\"modelica://OpenHPL.UsersGuide\">User's Guide</a>.</p>
</html>"));
end OpenHPL;
