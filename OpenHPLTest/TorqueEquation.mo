within OpenHPLTest;

package TorqueEquation
  extends Modelica.Icons.ExamplesPackage;
  import SI = Modelica.Units.SI;
  //

  model TorqueElement
     extends OpenHPL.Icons.ElectroMech;
     extends OpenHPL.ElectroMech.BaseClasses.TorqueEquation;
  equation

  end TorqueElement;

  model TorqueTest
    extends Modelica.Icons.Example;
    //
    parameter SI.Torque shaftTorque0 = 1.e+03;
    SI.Torque shaftTorque;
    inner OpenHPL.Data data annotation(
      Placement(transformation(origin = {-52, 74}, extent = {{-10, -10}, {10, 10}})));
    TorqueElement te1(J = 10, f_0 = 0, torque(y = shaftTorque), enable_f = true, p = 10) annotation(
      Placement(transformation(origin = {-30, 52}, extent = {{-10, -10}, {10, 10}})));
    TorqueElement te2(J = 10, f_0 = 0, torque(y = shaftTorque), enable_f = true, p = 22) annotation(
      Placement(transformation(origin = {-30, 24}, extent = {{-10, -10}, {10, 10}})));
    equation
    if (time > 0.1 and time < 0.4) then
      shaftTorque = shaftTorque0;
    elseif (time > 0.5 and time < 0.8) then
      shaftTorque = -shaftTorque0;
    else
      shaftTorque = 0.0;
    end if;
  annotation(
      Diagram(coordinateSystem(extent = {{-80, 80}, {-20, 0}})));
end TorqueTest;
end TorqueEquation;
