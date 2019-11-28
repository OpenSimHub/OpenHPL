within OpenHPL.Functions.KP07.KPfunctions;
model SlopeVectorS
  extends Icons.Method;
  parameter Integer N "number of segments";
  input Real U_[2 * (N + 4)], theta, dx;
  output Real s[2, N + 2];
protected
  Real s_m[2 * (N + 2), 1], s_c[2 * (N + 2), 1], s_p[2 * (N + 2), 1], s1[2 * (N + 2), 1];
  Real p_[N + 4], m_dot_[N + 4];
equation
  p_ = U_[1:N + 4];
  m_dot_ = U_[N + 5:2 * (N + 4)];
  s_m = theta * ([p_[2:N + 3]; m_dot_[2:N + 3]] - [p_[1:N + 2]; m_dot_[1:N + 2]]) / dx;
  s_c = ([p_[3:N + 4]; m_dot_[3:N + 4]] - [p_[1:N + 2]; m_dot_[1:N + 2]]) / 2 / dx;
  s_p = theta * ([p_[3:N + 4]; m_dot_[3:N + 4]] - [p_[2:N + 3]; m_dot_[2:N + 3]]) / dx;
  for i in 1:N + 2 loop
    s1[i, 1] = 0.5 * (sign(s_m[i, 1]) + sign(s_c[i, 1])) * min(abs(s_m[i, 1]), abs(s_c[i, 1]));
    s1[N + 2 + i, 1] = 0.5 * (sign(s_m[N + 2 + i, 1]) + sign(s_c[N + 2 + i, 1])) * min(abs(s_m[N + 2 + i, 1]), abs(s_c[N + 2 + i, 1]));
    s[1, i] = 0.5 * (sign(s1[i, 1]) + sign(s_p[i, 1])) * min(abs(s1[i, 1]), abs(s_p[i, 1]));
    s[2, i] = 0.5 * (sign(s1[N + 2 + i, 1]) + sign(s_p[N + 2 + i, 1])) * min(abs(s1[N + 2 + i, 1]), abs(s_p[N + 2 + i, 1]));
    //      if s_m[i,1]>0 and s_c[i,1]>0 and s_p[i,1]>0 then
    //        s[1,i] = min(min(s_m[i,1],s_c[i,1]),s_p[i,1]);
    //      elseif s_m[i,1]<0 and s_c[i,1]<0 and s_p[i,1]<0 then
    //        s[1,i] = max(max(s_m[i,1],s_c[i,1]),s_p[i,1]);
    //      else
    //        s[1,i] = 0;
    //      end if;
    //      if s_m[N + 2 + i,1]>0 and s_c[N + 2 + i,1]>0 and s_p[N + 2 + i,1]>0 then
    //        s[2,i] = min(min(s_m[N + 2 + i,1],s_c[N + 2 + i,1]),s_p[N + 2 + i,1]);
    //      elseif s_m[N + 2 + i,1]<0 and s_c[N + 2 + i,1]<0 and s_p[N + 2 + i,1]<0 then
    //        s[2,i] = max(max(s_m[N + 2 + i,1],s_c[N + 2 + i,1]),s_p[N + 2 + i,1]);
    //      else
    //        s[2,i] = 0;
    //      end if;
  end for;
  annotation (
    Documentation(info="<html>
<p>The model for defining the slope <i>s<sub>j</i></sub>  of the reconstructed function in each cell, which is computed using a limiter function to obtain a non-oscillatory nature of the reconstruction. The KP07 scheme utilizes the generalized minmod limiter:</p>
<p><img src=\"modelica://OpenHPL/Resources/Images/equations/KP_slope.svg\"/></p>
</html>"));
end SlopeVectorS;
