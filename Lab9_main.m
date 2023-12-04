%%%%%%%%%%%%%
% Kevin Duprey
% u1406068
% MEEN 2450 - 04
% 11/30/2023
%%%%%%%%%%%%%%

clear, clc, close all

load('EnvironmentalForcing.mat'); % load given arrays


% initial conditions
% Tb = zeros(1,length(tspan));
% for i = 1:length(tspan)
%     if T(i) > 0 && T(i) < 35
%         Tb(i) = 0.000214 * T(i)^(2.06737) * (35 - T(i))^(0.72859);
%     else
%         Tb(i) = 0;
%     end
% end
% Te(:) = -0.35968 + 0.10789 .* T(:) + 0.00214*T(:).^2;

beta = 1;    %rate infection increases (1/day)
%mu_L = sum(real(Tb));  %rate latent period ends (inverse of number of days latent)

%   mu_L(:) = latentperiod(); %STOLL CHANGE

mu_I = 10; %rate infection clears (inverse of number of days infectious)
days = 61;   %length of simulation (day)
dt   = 1/24; %timestep (fraction of a day)%STOLL CHANGE
Ap   = 5000; %normalization factor
P_i = 1.33*30*(-0.35968 + 0.10789 *15 + 0.00214*15*15)*30; % initial population
S_i  = P_i/Ap;    %initial size of the population (normalized)
L_i  = S_i*0.01; %initial fraction of population that is latent
I_i  = 0;    %initial fraction of population that is infectious
R_i  = I_i*mu_I;  %initial fraction of population that is recovered
Pb_i = 1; % initial berry population fraction
k    = 0.01;  %population growth rate (fraction per day)
e    = 0.001; %rate of introduction from external sources
mu_L_min = 6;

%[S,L,I,R,P,Pb,time] = PathogenGrowth_0D(S_i,L_i,I_i,R_i,P_i,Pb_i,beta,mu_I,k,e,Ap,mu_L_min,T,days,dt);

plot(tspan,T);
title('Temperature vs time');
xlabel('time (day)');
ylabel('temp (degrees C)');

betaVals = [0.5 , 1 , 1.5];
mu_LVals = [4 , 6 , 8];
for i = 1:3
    for j = 1:3
        [S,L,I,R,P,Pb,time] = PathogenGrowth_0D(S_i,L_i,I_i,R_i,P_i,Pb_i,betaVals(i),mu_I,k,e,Ap,mu_LVals(j),T,days,dt);
        figure();
        plot(time,S);
        hold on;
        plot(time,L);
        plot(time,I);
        plot(time,R);
        plot(time,Pb/Ap);%STOLL CHANGE
        plot(time,P/Ap);%STOLL CHANGE
        legend('S','L','I','R','Pb','P');
        xlabel('time (days)');
        ylabel('percent change')
        str = "beta = " + betaVals(i) + " mu_L = " + mu_LVals(j);
        title(str);
    end
end

% Beta is a value which represents the maximum rate of infection of the 
% species (/day). With this, as Beta increases, the latent period and 
% infected population values increase over time, meaning that the 
% susceptible population begins to decrease over time relative to the 
% actual population. By increasing the minimum latent period time, 
% the removal rate of the population increases dramatically, also causing 
% the susceptible population to fall away from the actual population over 
% time. By adding surface area to the model, we no longer treat each plant 
% as a single point for infections, but as a more complex body. This means 
% that plant growth throughout the time is taken into account, giving a 
% more realistic model. Real life temperature data expands on the addition 
% of surface area by allowing us to find the rate of growth of a plant at a 
% given temperature as a result of rates of photosynthesis. Using this 
% data, we can make assumptions regarding the time of year the 61-day 
% period occurred, and can use that to make inferences about infection 
% rates at different stages of the plant growth cycle.
