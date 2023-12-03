%%%%%%%%%%%%%
% Kevin Duprey
% u1406068
% MEEN 2450 - 04
% 11/30/2023
%%%%%%%%%%%%%%

clear all, clc, close all

load('EnvironmentalForcing.mat'); % load given arrays


% initial conditions
Tb = zeros(1,length(tspan));
for i = 1:length(tspan)
    if T(i) > 0 || T(i) < 35
        Tb(i) = 0.000214 * T(i)^(2.06737) * (35 - T(i))^(0.72859);
    else
        Tb(i) = 0;
    end
end
Te(:) = -0.35968 + 0.10789 .* T(:) + 0.00214*T(:).^2;
beta = 2;    %rate infection increases (1/day)
%mu_L = sum(real(Tb));  %rate latent period ends (inverse of number of days latent)
mu_L = 1/6; %STOLL CHANGE
mu_I = 0.25; %rate infection clears (inverse of number of days infectious)
days = 60;   %length of simulation (day)
dt   = 1/24; %timestep (fraction of a day)%STOLL CHANGE
Ap   = 5000; %normalization factor
P_i = 1.33*30*(-0.35968 + 0.10789 *15 + 0.00214*15*15)*30; % initial population
S_i  = P_i/Ap;    %initial size of the population (normalized)
L_i  = S_i*0.01; %initial fraction of population that is latent
I_i  = 0;    %initial fraction of population that is infectious
R_i  = I_i*mu_I;  %initial fraction of population that is recovered
Pb_i = 1; % initial berry population fraction
k    = 0.01;  %population growth rate (fraction per day)
e    = 0.005; %rate of introduction from external sources

[S,L,I,R,P,Pb,time] = PathogenGrowth_0D(S_i,L_i,I_i,R_i,P_i,Pb_i,beta,mu_L,mu_I,k,e,Ap,T,days,dt);

plot(tspan,T);

figure();
plot(time,S);
hold on;
plot(time,L);
plot(time,I);
plot(time,R);
plot(time,Pb/Ap);%STOLL CHANGE
plot(time,P/Ap);%STOLL CHANGE
legend('S','L','I','R','Pb','P');
