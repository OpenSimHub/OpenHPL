within OpenHPL.Functions.KP07.KPfunctions;
model GhostsCell
  extends Icons.Method;
  parameter Integer N "number of segments";
  input Real U[2 * N];
  //, 1];
  output Real U_[2 * (N + 4)];
  //, 1];
  output Real p_[N + 4], m_dot_[N + 4];
  //, 1],
  //, 1];
protected
  Real p[N], m_dot[N];
  //, 1],
  //, 1];
equation
  p = U[1:N];
  m_dot = U[N + 1:2 * N];
  p_[2] = 2 * p[1] - p[2];
  p_[1] = 2 * p_[2] - p[1];
  p_[N + 3] = 2 * p[N] - p[N - 1];
  p_[N + 4] = 2 * p_[N + 3] - p[N];
  m_dot_[2] = 2 * m_dot[1] - m_dot[2];
  m_dot_[1] = 3 * m_dot[1] - 2 * m_dot[2];
  m_dot_[N + 3] = 2 * m_dot[N] - m_dot[N - 1];
  m_dot_[N + 4] = 3 * m_dot[N] - 2 * m_dot[N - 1];
  p_[3:N + 2] = p;
  m_dot_[3:N + 2] = m_dot;
  U_ = vector([p_; m_dot_]);
  annotation (
    Documentation(info = "<html>
<p>The model for defining the ghosts cells. It can be observed that for a given <i>j<sup>th</i></sup> cell, information from the neighbouring cells <i>j-1</i> and <i>j-2</i> (to the left) and <i>j+1</i> and<i> j+2</i> (to the right) are required for calculating the flux integrals.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/ghosts.png\"/></p>
<p>Here is the equations that are used in this function:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/ghost_eq.png\"/></p>
</html>"));
end GhostsCell;
