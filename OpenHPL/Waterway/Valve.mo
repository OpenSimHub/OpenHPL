within OpenHPL.Waterway;
model Valve "Simple hydraulic valve"
  extends ElectroMech.BaseClasses.BaseValve;

    extends Icons.Valve;

  Modelica.Blocks.Interfaces.RealInput opening(min=0, max=1)
    "=1: completely open, =0: completely closed"
  annotation (Placement(transformation(
        origin={0,120},
        extent={{-20,-20},{20,20}},
        rotation=270), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,80})));
equation


  connect(opening, u) annotation (Line(points={{0,120},{0,70}}, color={0,0,127}));
  annotation (
    Documentation(info="<html><p>
This is a simple model of hydraulic valve.
The model can use a constant efficiency or varying
efficiency from a lookup-table.
</p>
<p>
This model is based on the energy balance of a valve.
The valve capacity can either be specified
directly by the user by specifying <code>C_v</code> or it will be calculated from
the nominal head <code>H_n</code> and nominal flow rate <code>Vdot_n</code>.
</p>
<p>
The valve efficiency is in per-unit values from 0 to 1, where 1 means that there are no losses in the valve.
The valve power is defined as the product of the valve power and valve efficiency.
</p>
<p>
Besides hydraulic input and output,
there is an input <code>u</code> for controlling the valve opening.
</p>
</html>"));
end Valve;
