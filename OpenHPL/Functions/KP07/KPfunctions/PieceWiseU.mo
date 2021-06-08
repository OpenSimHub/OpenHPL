within OpenHPL.Functions.KP07.KPfunctions;
model PieceWiseU
  extends Icons.Method;
  parameter Integer N(start=2) "number of segments";
  input Real dx, boun[2, 2], theta;
  input Real U[2 * N], B[N + 4];
  input Boolean bounCon[2, 2];
  output Real U_[8, N];
protected
  Real U_mm[2, N], U_mp[2, N], U_pm[2, N], U_pp[2, N], p_ghosts[N + 4], mdot_ghosts[N + 4], s[2, N + 2];
public
  GhostCells ghostCells(N=N, U=U);
  SlopeVectorS slopeVectorS(
    N=N,
    U_=vector([p_ghosts; mdot_ghosts]),
    theta=theta,
    dx=dx);
equation
  // ghost cells
  p_ghosts = ghostCells.p_ + B;
  mdot_ghosts = ghostCells.mdot_;
  // slope vector
  s = slopeVectorS.s;
  // piece wise
  U_mp = transpose([p_ghosts[3:N + 2], mdot_ghosts[3:N + 2]]) + dx * s[:, 2:N + 1] / 2;
  U_pp[:, 1:N - 1] = transpose([p_ghosts[4:N + 2], mdot_ghosts[4:N + 2]]) - dx * s[:, 3:N + 1] / 2;
  U_mm[:, 2:N] = transpose([p_ghosts[3:N + 1], mdot_ghosts[3:N + 1]]) + dx * s[:, 2:N] / 2;
  U_pm = transpose([p_ghosts[3:N + 2], mdot_ghosts[3:N + 2]]) - dx * s[:, 2:N + 1] / 2;
  U_mm[1, 1] = if bounCon[1, 1] then boun[1, 1] else p_ghosts[2] + dx * s[1, 1] / 2;
  U_pp[1, N] = if bounCon[2, 1] then boun[2, 1] else p_ghosts[N + 3] - dx * s[1, N + 2] / 2;
  U_mm[2, 1] = if bounCon[1, 2] then boun[1, 2] else mdot_ghosts[2] + dx * s[2, 1] / 2;
  U_pp[2, N] = if bounCon[2, 2] then boun[2, 2] else mdot_ghosts[N + 3] - dx * s[2, N + 2] / 2;
  // output vector U_
  U_ = [U_mp; U_pp; U_mm; U_pm];
  annotation (
    Documentation(info="<html>
<p>The piecewise linear reconstruction model, where the values of the left and the right interfaces of the cell (j-1/2 and j+1/2) at the right(+)/left(-) point values are defined.</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_piecewise.svg\"/></p>
</html>"));
end PieceWiseU;
