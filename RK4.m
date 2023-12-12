function x_array = RK4(ode,x_i,t)
% t is the current time index
n = length(t);
x_array = zeros(n,6);
x_array(1,:) = x_i;
k1 = zeros(size(x_array));
k2 = zeros(size(x_array));
k3 = zeros(size(x_array));
k4 = zeros(size(x_array));



    for i = 2:n
        h = t(i) - t(i-1);
        k1(i,:) = ode(t(i),x_array(i-1,:)); 
        k2(i,:) = ode(t(i)+0.5*h,x_array(i-1,:)+0.5*k1(i,:)*h);
        k3(i,:) = ode(t(i)+0.5*h,x_array(i-1,:)+0.5*k2(i,:)*h);
        k4(i,:) = ode(t(i)+h,x_array(i-1,:)+k3(i,:)*h);
        
        phi = (k1(i,:)+2.*k2(i,:)+2.*k3(i,:)+k4(i,:))./6;
        
        step = phi .* h;
        x_array(i,:) = x_array(i-1,:) + step;
    end


end