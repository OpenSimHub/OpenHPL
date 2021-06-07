within OpenHPL.Functions.KP07;
model KPmethod
  extends Icons.Method;
  parameter Integer N(start=2) "number of segments";
  input Real U[2 * N] "state vector", dx "length step", theta = 1.3 "parameter for slope limiter", S_[2 * N] "source term vector S", F_[2 * N, 4] "vector F", lam1[N, 4] "matrix of eigenvalues '+'", lam2[N, 4] "matrix of eigenvalues '-'", B[N + 4] = zeros(N + 4) "additional for open channel", boundary[2, 2] "values for boundary conditions";
  input Boolean boundaryCon[2, 2] "boundary conditions consideration";
  output Real diff_eq[2 * N] "right hand side for KP solution";
  Real U_[8, N] "matrix with boundary state values. Can be extracted";
protected
  Real H_[2 * N, 2] "matrix of fluxes", A_speed[N, 4] "matrix of one-side local speeds propagation";
public
  KPfunctions.PieceWiseU pieceWiseU(
    N=N,
    theta=theta,
    U=U,
    B=B,
    dx=dx,
    boun=boundary,
    bounCon=boundaryCon) "use function for defing the piece wise linear reconstruction of vector U";
  KPfunctions.SpeedPropagationApipe speedA(N = N, lamda1 = lam1, lamda2 = lam2) "use function for defing the one-side local speeds propagation";
  KPfunctions.FluxesH fluxesH(N = N, U_ = U_, A_ = A_speed, F_ = F_) "use function for defing the central upwind numerical fluxes";
equation
  ///// piece wise linear reconstruction of vector U
  U_ = pieceWiseU.U_;
  ///// one-side local speeds propagation
  A_speed = speedA.A;
  //A_speed = Functions.KP07.KPfunctions.SpeedPropagationApipeF(N, lam1, lam2);
  ///// central upwind numerical fluxes
  H_ = fluxesH.H;
  //H_ = Functions.KP07.KPfunctions.FluxesHF(N, U_, A_speed, F_);
  //// right hand side of diff. equation
  diff_eq = (-(H_[:, 1] - H_[:, 2]) / dx) + S_;
  annotation (
    Documentation(info="<html>
<p>This is a well-balanced second order scheme, which is a Reimann problem solver free scheme (central scheme) while at the same time it takes the advantage of the upwind scheme by utilizing the local, one side speed of propagation (given by the eigenvalues of the Jacobian matrix) during the calculation of the flux at the cell interfaces. </p>
<h4>Method description</h4>
<p>The central-upwind numerical scheme is presented for one dimensional case. </p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_pde.svg\"></p>
<p>The semi-discrete (time dependent ODEs) central-upwind scheme can be then written in the following from: </p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KPScheme.svg\"/></p>
<p>Here, in this function, the right hand side of the previous equation for the solution of KP07 scheme is calculated and returns as a output.</p>
<p>The central upwind numerical fluxes at the cell interfaces are given by:</p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_fluxes.svg\"/></p>
<p>For calculating the numerical fluxes <i>H<sub>i&plusmn;&frac12;</sub>(t)</i> and the values of U<sub>i&plusmn;&frac12;</sub> are needed. These can be calculated as the end points of a piecewise linearly reconstructed function: </p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_piecewise.svg\"/></p>
<p>The slope <em>s<sub>i</sub></em> of the reconstructed function in each cell is computed using a limiter function to obtain a non-oscillatory nature of the reconstruction. The KP07 scheme utilizes the generalized minmod limiter as: </p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_slope.svg\"/></p>
<p>The ghost cells that are needed for thiese calculations can be defined in the following way:</p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_ghost.svg\"/></p>
<p>Also the one-sided local speed of propagations can be estimated as the largest and the smallest eigen values of the Jacobian of the system as: </p>
<p align=\"center\"><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_speed.svg\"/></p>
<h5>Parameters/variables description</h5>
<p>This function needs the following input variables:</p>
<ul>
<li>vector: <code>U[2N,1]</code></li>
<li>number of segments: <code>N</code></li>
<li>step change of length: <code>&Delta;x</code></li>
<li>parameter: <code>&theta;</code></li>
<li>matrix: <code>F(U<sup>&plusmn;</sup><sub>i&plusmn;&frac12;</sub>)[2N,4]</code></li>
<li>vector: <code>S(U)[2N,1]</code> </li>
<li>matrix of eigenvalues: <code>&lambda;<sub>1,2</sub>(U<sup>&plusmn;</sup><sub>i&plusmn;&frac12;</sub>)[N,4];</code></li>
<li>vector B which is additional for defing ghost cells and can be used for, e.g., an open channel 
  (state <code>z=h+B</code>). In this case the input state vector <code>U</code> should include <code>h</code>,
  but the piecewise linear reconstruction of states will be done with <code>z</code></li>
<li>information about boundary conditions, as a matrix [2,2] of booleans true/false - depend on, which variable should be used</li>
<li>matrix with values for boundary conditions [2,2]</li>
</ul>
<p>In order to calculate matrix <code>F</code> and eigenvalues, it is possible to take out of the 
function the piecewise linear reconstruction of states matrix <code>U<sup>&plusmn;</sup><sub>i&plusmn;&frac12;</sub></code>.
 This matrix consists of following vectors <code>U<sup>&plusmn;</sup><sub>i&plusmn;&frac12;</sub>
  = [U<sup>-</sup><sub>i+&frac12;</sub> U<sup>+</sup><sub>i+&frac12;</sub>
     U<sup>-</sup><sub>i-&frac12;</sub> U<sup>+</sup><sub>i-&frac12;</sub>]</code>.</p>
<p>Examples of using this scheme are presented in 
<a href=\"modelica://OpenHPL.Functions.KP07.TestKPpde\">KP07.TestKPpde</a>.</p>
</html>"));
end KPmethod;
