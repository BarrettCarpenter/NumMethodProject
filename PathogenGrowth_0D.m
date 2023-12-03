% Script to compute the increase in icidence of a plant pathogen (or any
% pathogen with stationary hosts).  This code is 0-D (time only) and
% predicts the growth of the pathogen for a host with a population that
% grows in size with time.
%
% The primary equations governing this are compound interest equations for
% growth:
%
% dS/dt = -beta*S*I+k
%
% dL/dt = beta*S*I-mu_l*L+e
%
% dI/dt = mu_l*L*I-mu_i*I
%
% dR/dt = mu_i*I
%
% with:
% S    = susceptible fraction of population (susceptible tissue)
% beta = rate of infection growth for healthy population (fraction per day)
% L    = fraction of tissue infected and latent (e.g., dormant before infection)
% I    = fraction of tissue infected and producing inoculum
% R    = fraction of tissue recovered (or removed) from population
% t    = time
% mu_l = rate of decrease in latent population (fraction per day)
% mu_i = rate of decrease in infectious population (fraction per day)
% k    = growth rate of the host population (fraction per day)
% e    = rate of import from external sources
%
% inputs: S_i (initial size of susceptible population); k; beta; mu;
% days (number of days to simulate); dt (time step,fraction of a day)
% output: S,I,R,time (vector of simulation times)

function [S,L,I,R,P,Pb,time] = PathogenGrowth_0D(S_i,L_i,I_i,R_i,P_i,Pb_i,beta,mu_L,...
    mu_I,k,e,Ap,T,days,dt)

% derived running conditions
Nsteps = ceil(days/dt); % has 1200 steps
time = (1:Nsteps-1)*dt;


% set parameters
p(1) = beta; %(rate of new infections)
p(2) = mu_L; %(inverse length of latent period in days)
p(3) = mu_I; %(inverse length of the infectious period in days)
p(4) = k;    %(population growth rate)
p(5) = e;    %(rate of new infections from external sources)
p(6) = Ap;   
p(7) = dt;


% declare function handles
odefun = @(t,y) SLIRmodel(t,y,p,T);

% set initial conditions
% simulation starts when first member of the population becomes infectious
y0(1) = S_i; %(initial susceptible population fraction)
y0(2) = L_i; %(initial latent population fraction)
y0(3) = I_i; %(initial infectious population fraction)
y0(4) = R_i; %(initial recovered population fraction)
y0(5) = P_i; %(initial population fraction)
y0(6) = Pb_i;%(initial berry population fraction)

% integrate using Euler's method
[~,dydt] = euler(odefun,time,y0');

% set outputs
S = dydt(:,1);
L = dydt(:,2);
I = dydt(:,3);
R = dydt(:,4);
P = dydt(:,5);
Pb = dydt(:,6);

end 