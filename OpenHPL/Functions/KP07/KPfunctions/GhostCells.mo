within OpenHPL.Functions.KP07.KPfunctions;
model GhostCells
  extends Icons.Method;
  parameter Integer N(start=2) "Number of segments";
  input Real U[2 * N];
  //, 1];
  output Real U_[2 * (N + 4)];
  //, 1];
  output Real p_[N + 4], mdot_[N + 4];
  //, 1],
  //, 1];
protected
  Real p[N], mdot[N];
  //, 1],
  //, 1];
equation
  p = U[1:N];
  mdot = U[N + 1:2 * N];
  p_[2] = 2 * p[1] - p[2];
  p_[1] = 2 * p_[2] - p[1];
  p_[N + 3] = 2 * p[N] - p[N - 1];
  p_[N + 4] = 2 * p_[N + 3] - p[N];
  mdot_[2] = 2 * mdot[1] - mdot[2];
  mdot_[1] = 3 * mdot[1] - 2 * mdot[2];
  mdot_[N + 3] = 2 * mdot[N] - mdot[N - 1];
  mdot_[N + 4] = 3 * mdot[N] - 2 * mdot[N - 1];
  p_[3:N + 2] = p;
  mdot_[3:N + 2] = mdot;
  U_ = vector([p_; mdot_]);
  annotation (preferredView="info",
    Documentation(info="<html>
<p>The model for defining the ghost cells. It can be observed that for a given <code>j<sup>th</sup></code> cell, information from the neighbouring cells <em>j-1</em> and <em>j-2</em> (to the left) and <em>j+1</em> and<em> j+2</em> (to the right) are required for calculating the flux integrals.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/ghosts.svg\"/></p>
<p>Here is the equations that are used in this function:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_ghost.svg\"/></p>
</html>"));
end GhostCells;
