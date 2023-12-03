%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% SLIR function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SLIRmodel combines all the SLIR equations into one system.  
% the dependent variables are stored in y as:
% y(1) = S (susceptible population)
% y(2) = L (latent population)
% y(3) = I (infectious population)
% y(4) = R (recovered/removed population)
%
% with parameters
% p(1) = beta (rate of new infections)
% p(2) = mu_l (inverse length of latent period in days)
% p(3) = mu_i (inverse length of the infectious period in days)
% p(4) = k (population growth rate)
% p(5) = e (rate of new infections from external sources)

function [dydt] = SLIRmodel(t,y,p,T)
    
    t = floor(t) % round value for now to not throw error

    % temperature
    if T(t) > 0 || T(t) < 35
        Tb = 0.000214 * T(t)^(2.06737) * (35 - T(t))^(0.72859);
    else
        Tb = 0;
    end
    Te = -0.35968 + 0.10789 * T(t) - 0.00214*T(t)^2; %STOLL CHANGE
    
    % day
    tday = floor(t/24)+1; % find current day based on index %STOLL CHANGE

    %assign parameters
    beta = Tb * p(1);
    mu_l = p(2);
    mu_i = p(3);
    k    = p(4);
    e    = p(5);
    Ap   = p(6);
    dpldt = (1.33 * tday) * Te;

    %assign variables
    S = y(1);
    L = y(2);
    I = y(3);
    R = y(4);
    P = y(5);
    Pb = y(6);

    dydt(6) = (0.1724*Pb - 0.0000212*(Pb^2)) * Te; % Pb
    dydt(5) = dydt(6) + dpldt;          % P
    dydt(1) = -beta*S*I + dydt(5) * (1/Ap); % S
    dydt(2) = beta*S*I - mu_l*L + e;         % L %STOLL CHANGE
    dydt(3) = mu_l*L-mu_i*I;            % I
    dydt(4) = mu_i*I;                   % R
    
end