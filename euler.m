% EULER Uses Euler's Method to calculate the solution to an ODE.
%
% [t, states] = euler(odefun, tspan, y0) uses Euler's Method to calculate
%   the solution to the ODE defined by the system of equations odefun, over the
%   time steps defined by tspan, with the initial conditions y0.  The time
%   output is stored in the array t, while the dependent variables are stored in
%  the array states.  Euler's Method uses the equation:
%                       dY
%       Y(i+1) = Y(i) + -- delta_t
%                       dt
%   where delta_t is the time step, Y(i) is the values of the dependent
%   variables at the current time, Y(i+1) is the values of the dependent
%   variables at the next time, and dY/dt is the derivative function
%   evaluated at the current time.
%
% Inputs:
%   odefun - A function handle to the derivative function defining the system.
%   tspan - An array of t (or other independent variable) at which to evaluate
%           Euler's Method.  The num_times values in this array determine the size
%           of the outputs.
%   y0    - A value containing the initial condition to be used in evaluating
%           the derivative_function.  Must be the same size as that expected fo
%           the second input of derivative_function.
%
% Outputs:
%   t  - A (num_times, 1) array of times (or other independent variable) at which
%        Euler's Method was evaluated.
%   y - A (num_times, 1) array of dependent variables at which Euler's Method was
%       evaluated.
%
% Sample Usage:
%
%   >> [t,y] = euler(@ball_motion,0:5,50)
%   t =
%        0
%        1
%        2
%        3
%        4
%        5
%   y =
%      50.0000
%      -6.9239
%     -17.6275
%     -33.2847
%     -63.9675
%    -150.8969
%

function [t, y] = euler(odefun, tspan, y0)

    % Determine number of items in outputs
    if size(y0, 2) ~= 1
        error('y0 must be a column vector');
    end
    num_times = length(tspan);
    num_states = max(length(y0), 1);

    % Initialize outputs
    t = zeros(num_times, 1);
    y = zeros(num_times, num_states);

    % Assign first row of outputs
    t(1) = tspan(1);
    y(1,:) = y0;

    % Assign other rows of output
    for idx = 2:(num_times)%STOLL CHANGE
        % Calculate slopes at current time
%        yprime = zeros(length(y0),1);
        
%        yprime = odefun(idx, y(idx-1,:)); % find the derivatives %STOLL CHANGE
yprime = RK4(@(t,y)ode(t,y),y0(idx-1,:),idx)

%yprime(:) = odefun(t(idx),y(idx,:));
        % Calculate next state
        dt = tspan(idx) - tspan(idx-1);
        y(idx,:) = y(idx-1,:) + yprime * dt; 
        t(idx) = tspan(idx);

    end % idx

end % function