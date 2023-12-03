function x_array = RK4(ode,x_i,t)
% t is the current time index
n = length(x_i);
x_array = zeros(1,n);


    h = 1;
    k1(:) = ode(t,x_array(:)); 
    k2(:) = ode(t+0.5*h,x_array(:)+0.5*k1*h);
    k3(:) = ode(t+0.5*h,x_array(:)+0.5*k2*h);
    k4(:) = ode(t+h,x_array(:)+k3*h);
    
    phi(:) = (k1(:)+2.*k2(:)+2.*k3(:)+k4(:))./6;
    
    step(:) = phi(:) .* h;
    xi(:) = x_i(:)';
    x_array(:) = xi(:) + step(:);


end