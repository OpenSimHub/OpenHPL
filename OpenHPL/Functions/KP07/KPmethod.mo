within OpenHPL.Functions.KP07;
model KPmethod
  extends Icons.Method;
  parameter Integer N "number of segments";
  input Real U[2 * N] "state vector", dx "length step", theta = 1.3 "parameter for slope limiter", S_[2 * N] "source term vector S", F_[2 * N, 4] "vector F", lam1[N, 4] "matrix of eigenvalues '+'", lam2[N, 4] "matrix of eigenvalues '-'", B[N + 4] = zeros(N + 4) "additional for open channel", boundary[2, 2] "values for boundary conditions";
  input Boolean boundaryCon[2, 2] "boundary conditions consideration";
  output Real diff_eq[2 * N] "right hand side for KP solution";
  Real U_[8, N] "matrix with boundary state values. Can be extracted";
protected
  Real H_[2 * N, 2] "matrix of fluxes", A_speed[N, 4] "matrix of one-side local speeds propagation";
public
  KPfunctions.WiseU wiseU(N = N, theta = theta, U = U, B = B, dx = dx, boun = boundary, bounCon = boundaryCon) "use function for defing the piece wise linear reconstruction of vector U";
  KPfunctions.SpeedPropagationApipe speedA(N = N, lamda1 = lam1, lamda2 = lam2) "use function for defing the one-side local speeds propagation";
  KPfunctions.FluxesH fluxesH(N = N, U_ = U_, A_ = A_speed, F_ = F_) "use function for defing the central upwind numerical fluxes";
equation
  ///// piece wise linear reconstruction of vector U
  U_ = wiseU.U_;
  ///// one-side local speeds propagation
  A_speed = speedA.A;
  //A_speed = Functions.KP07.KPfunctions.SpeedPropagationApipeF(N, lam1, lam2);
  ///// central upwind numerical fluxes
  H_ = fluxesH.H;
  //H_ = Functions.KP07.KPfunctions.FluxesHF(N, U_, A_speed, F_);
  //// right hand side of diff. equation
  diff_eq = (-(H_[:, 1] - H_[:, 2]) / dx) + S_;
  annotation (
    Documentation(info = "<html>
<p>This is a well-balanced second order scheme, which is a Reimann problem solver free scheme (central scheme) while at the same time it takes the advantage of the upwind scheme by utilizing the local, one side speed of propagation (given by the eigenvalues of the Jacobian matrix) during the calculation of the flux at the cell interfaces. </p>
<p><b><span style=\"font-size: 12pt; color: #0000ff;\">Method description</span></b></p>
<p>The central-upwind numerical scheme is presented for one dimensional case. </p>
<p><img src=\"modelica://OpenHPL/Resources/Images/pde.png\"/></p>
<p>The semi-discrete (time dependent ODEs) central-upwind scheme can be then written in the following from: </p>
<p><img src=\"modelica://OpenHPL/Resources/Images/eq.png\"/></p>
<p>Here, in this function, the right hand side of the previous equation for the solution of KP07 scheme is calculated and returns as a output.</p>
<p>The central upwind numerical fluxes at the cell interfaces are given by:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/eq_flauxes.png\"/></p>
<p>For calculating the numerical fluxes <i>H<sub>i+/-1/2</sub>(t)</i> and the values of U<sup>+/-</sup>i+/-1/2 are needed. These can be calculated as the end points of a piecewise linearly reconstructed function: </p>
<p><img src=\"modelica://OpenHPL/Resources/Images/piece_wise_eq.png\"/></p>
<p>The slope <i>s<sub>i</i></sub> of the reconstructed function in each cell is computed using a limiter function to obtain a non-oscillatory nature of the reconstruction. The KP07 scheme utilizes the generalized minmod limiter as: </p>
<p><img src=\"modelica://OpenHPL/Resources/Images/slope_eq.png\"/></p>
<p>The ghosts cells that are needed for thiese calculations can be defined in the following way:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/ghost_eq.png\"/></p>
<p>Also the one-sided local speed of propagations can be estimated as the largest and the smallest eigen values of the Jacobian of the system as: </p>
<p><img src=\"modelica://OpenHPL/Resources/Images/eq_speed_propag.png\"/></p>
<p><b><span style=\"font-size: 12pt; color: #0000ff;\">Parameters/variables description</span></b></p>
<p>As a input for this function should be provided:</p>
<ul>
<li>vector <i>U[2N,1];</i></li>
<li>number of segments <i>N;</i></li>
<li>step change of length <i>&Delta;x;</i></li>
<li>parameter <i>&theta;;</i></li>
<li>matrix <i>F(U<sup>+/-</sup>i+/-1/2)[2N,4];</i></li>
<li>vector <i>S(U)[2N,1]</i> </li>
<li>matrix of eigenvalues <i>&lambda;<sub>1,2</sub>(U<sup>+/-</sup>i+/-1/2)[N,4];</i></li>
<li>vector B which is additional for defing ghost cells and can be use e.g. for open channe (state <i>z=h+B</i>). In this case input state vector <i>U</i> should include <i>h</i>, but the piecewise linear reconstruction of states will be done with <i>z</i>;</li>
<li>information about boundary conditions, as a matrix [2,2] of booleans true/false - depend on, which variable should be used</li>
<li>matrix with values for boundary conditions [2,2]</li>
</ul>
<p>In order to calculate matrix <i>F</i> and eigenvalues, it is possible to take out of the function the piecewise linear reconstruction of states matrix <i>U<sup>+/-</sup>i+/-1/2</i> . This matrix consists of following vectors <i>U<sup>+/-</sup>i+/-1/2 = [U<sup>-</sup>i+1/2; U<sup>+</sup>i+1/2; U<sup>-</sup>i-1/2; U<sup>+</sup>i-1/2]</i>.</p>
<p>Examples of using this scheme is presented in KP07.TestKPpde.</p>
</html>"));
end KPmethod;
