within OpenHPL.Functions.KP07.KPfunctions;
function FluxesHF
  input Integer N "number of segments";
  input Real U_[8, N], A_[N, 4], F_[2 * N, 4];
  output Real H[2 * N, 2];
protected
  Real H_p[2 * N], H_m[2 * N];
  Real a_mp[2 * N], a_pp[2 * N], a_mm[2 * N], a_pm[2 * N];
algorithm
  // speed propagation
  a_mp := vector([A_[:, 1]; A_[:, 1]]);
  a_pp := vector([A_[:, 2]; A_[:, 2]]);
  a_mm := vector([A_[:, 3]; A_[:, 3]]);
  a_pm := vector([A_[:, 4]; A_[:, 4]]);
  // Fluxes
  H_p := (a_pp .* F_[:, 1] - a_mp .* F_[:, 2]) ./ (a_pp - a_mp) + a_pp .* a_mp ./ (a_pp - a_mp) .* vector([U_[3, :]; U_[4, :]] - [U_[1, :]; U_[2, :]]);
  H_m := (a_pm .* F_[:, 3] - a_mm .* F_[:, 4]) ./ (a_pm - a_mm) + a_pm .* a_mm ./ (a_pm - a_mm) .* vector([U_[7, :]; U_[8, :]] - [U_[5, :]; U_[6, :]]);
  H := [H_p, H_m];
  annotation (
    Documentation(info = "<html>
<p>The model for defining the central upwind numerical fluxes at the cell interfaces.</p>
</html>"));
end FluxesHF;
