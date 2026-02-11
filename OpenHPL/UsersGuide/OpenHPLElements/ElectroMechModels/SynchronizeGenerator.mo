within OpenHPL.UsersGuide.OpenHPLElements.ElectroMechModels;
class SynchronizeGenerator "Description of synchronous generator model"
  extends Modelica.Icons.Information;
  annotation (Documentation(info="<html>
<h4>Synchronous Generator</h4>
<p>
Here, a more detailed model of the synchronous generator is presented. This model is based on the d-q decomposition 
and assumed that the generator is connected to the grid. The voltage-current relation is given as:
</p>
<p>
$$ \\left[\\begin{matrix}R_a+R_e & x_q'+x_e\\\\ -x_d'-x_e & R_a+R_e\\end{matrix}\\right]\\left[\\begin{matrix}I_d \\\\ I_q\\end{matrix}\\right]= \\left[\\begin{matrix}E_d'+V_s\\sin\\delta_e \\\\ E_q'-V_s\\cos\\delta_e\\end{matrix}\\right] $$
</p>
<p>
Here, \\(R_a\\) and \\(R_e\\) are the phase winding and equivalent network resistances, \\(x_d\\), \\(x_q\\), \\(x_d'\\), 
and \\(x_q'\\) are d-/q-axis normal, and transient reactances. \\(x_e\\) is the equivalent network reactance. \\(I_d\\) 
and \\(I_q\\) are the d-/q-axis currents. \\(E_d'\\) and \\(E_q'\\) are the d-/q-axis transient voltages. \\(V_s\\) is 
the network RMS (Root-Mean-Squared) voltage. \\(\\delta_e\\) is the phase shift angle that is described as follows:
</p>
<p>
$$ \\frac{d\\delta_e}{dt} = (\\omega - \\omega_s)\\frac{n_p}{2} $$
</p>
<p>
Here, \\(n_p\\) is the number of poles in the generator, where \\(\\omega\\) and \\(\\omega_s\\) are the generator and 
grid angular velocities, respectively. The Swing equation is used to describe the angular velocity dynamics and looks as 
follows:
</p>
<p>
$$ \\frac{d\\omega}{dt}=\\frac{\\dot{W}_s-P_e}{J\\omega} $$
</p>

<p>
The dynamic equations for the transient operation are as follows:
</p>
<p>
$$
\\begin{array}{c}
T_{qo}'\\frac{dE_d'}{dt} =-E_d' + (x_q' - x_q)I_q \\\\
T_{do}'\\frac{dE_q'}{dt} = -E_q' + (x_d - x_d')I_d + E_f
\\end{array}
$$
</p>
<p>
Here, \\(T_{do}'\\) and \\(T_{qo}'\\) are the d-/q-axis transient open-circuit time constants. \\(E_f\\) is the voltage 
across the field winding with the following dynamic equation:
</p>
<p>
$$ \\frac{dE_f}{dt} = \\frac{-E_f + K_E\\left(V_{tr}-V_t-V_{stab}\\right)}{T_E} $$
</p>
<p>
Here, \\(K_E\\) is the excitation system gain and \\(T_E\\) --- excitation system time constant. \\(V_{tr}\\) is the 
voltage reference set point for the exciter. \\(V_t\\) is the terminal voltage and can be found as 
\\(V_t = \\sqrt{\\left(E_d'-R_aI_d-x_q'I_q\\right)^2+\\left(E_q'-R_aI_q+x_d'I_d\\right)^2}\\). \\(V_{stab}\\) is the 
stabilisation voltage with the following dynamic equation:
</p>
<p>
$$ \\frac{dV_{stab}}{dt} = \\frac{-V_{stab} + K_F\\frac{dE_f}{dt}}{T_{FE}} $$
</p>
<p>
Here, \\(K_F\\) is the stabiliser gain, and \\(T_{FE}\\) --- the stabiliser time constant.
</p>

<p>
The output active and reactive power of the generator can be found as follows:
</p>
<p>
$$
\\begin{array}{c}
P_e = 3\\left(E_d'I_d+E_q'I_q\\right)\\\\
Q_e = \\sqrt{9V_t^2I_t^2-P_e^2}
\\end{array}
$$
</p>
<p>
Here, the terminate current is given as \\(I_t=\\sqrt{I_d^2+I_q^2}\\).
</p>

<h5>Implementation</h5>
<p>
Hence, this synchronise generator model is encoded in the <em>OpenHPL</em> as a <em>SynchGen</em> unit. This unit has 
inputs as the turbine shaft power, that is implemented with the standard Modelica <em>RealInput</em> connector. This 
<em>SynchGen</em> unit also uses the standard Modelica <em>RealOutput</em> connectors in order to provide output 
information about the angular velocity and frequency of the generator. All these connectors can be connected to turbines 
units and other standard Modelica blocks.
</p>

<h5>Parameters</h5>
<p>
In the <em>SynchGen</em> unit, the user can specify the required nominal parameters for the generator: active and reactive 
powers drawn from the generator at Steady-State operating condition, phase winding resistance, and the number of poles. 
The following network parameters should be also specified by the user: equivalent network resistance and reactance, network 
RMS voltage, grid angular velocity. The user also specifies the d-/q-axis normal and transient reactances, d-/q-axis 
transient open-circuit time constants, minimum and maximum field voltages, excitation system, stabilizer gains, time 
constants, moment of inertia of the generator, and the friction factor in the rotor bearing box. This unit can be 
initialized, or the user can decide on an option for the self initialisation.
</p>
</html>", revisions=""));
end SynchronizeGenerator;
