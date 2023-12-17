function y = TimeInt(ode,t,dt,y0,depflux_sum,mu_L)
e = depflux_sum;

dydt = ode(t,y0,e,mu_L);

y = y0 + dydt*dt;

end