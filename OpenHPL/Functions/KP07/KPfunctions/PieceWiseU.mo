within OpenHPL.Functions.KP07.KPfunctions;
model PieceWiseU
  extends Icons.Method;
  parameter Integer N(start=2) "number of segments";
  input Real dx, boun[2, 2], theta;
  input Real U[2 * N], B[N + 4];
  input Boolean bounCon[2, 2];
  output Real U_[8, N];
protected
  Real U_mm[2, N], U_mp[2, N], U_pm[2, N], U_pp[2, N], p_ghosts[N + 4], m_dot_ghosts[N + 4], s[2, N + 2];
public
  GhostCells ghostsCell(N=N, U=U);
  SlopeVectorS slopeVectoreS(
    N=N,
    U_=vector([p_ghosts; m_dot_ghosts]),
    theta=theta,
    dx=dx);
equation
  // ghosts cells
  p_ghosts = ghostsCell.p_ + B;
  m_dot_ghosts = ghostsCell.m_dot_;
  // slove vector
  s = slopeVectoreS.s;
  // pieace wise
  U_mp = transpose([p_ghosts[3:N + 2], m_dot_ghosts[3:N + 2]]) + dx * s[:, 2:N + 1] / 2;
  U_pp[:, 1:N - 1] = transpose([p_ghosts[4:N + 2], m_dot_ghosts[4:N + 2]]) - dx * s[:, 3:N + 1] / 2;
  U_mm[:, 2:N] = transpose([p_ghosts[3:N + 1], m_dot_ghosts[3:N + 1]]) + dx * s[:, 2:N] / 2;
  U_pm = transpose([p_ghosts[3:N + 2], m_dot_ghosts[3:N + 2]]) - dx * s[:, 2:N + 1] / 2;
  U_mm[1, 1] = if bounCon[1, 1] == true then boun[1, 1] else p_ghosts[2] + dx * s[1, 1] / 2;
  U_pp[1, N] = if bounCon[2, 1] == true then boun[2, 1] else p_ghosts[N + 3] - dx * s[1, N + 2] / 2;
  U_mm[2, 1] = if bounCon[1, 2] == true then boun[1, 2] else m_dot_ghosts[2] + dx * s[2, 1] / 2;
  U_pp[2, N] = if bounCon[2, 2] == true then boun[2, 2] else m_dot_ghosts[N + 3] - dx * s[2, N + 2] / 2;
  // output vector U_
  U_ = [U_mp; U_pp; U_mm; U_pm];
  annotation (
    Documentation(info="<html>
<p>The piecewise linear reconstruction model, where the values of the left and the right interfaces of the cell (j-1/2 and j+1/2) at the right(+)/left(-) point values are defined.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_piecewise.svg\"/></p>
</html>"));
end PieceWiseU;
