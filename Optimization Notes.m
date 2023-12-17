%% Optimization notes
%Random Search method
% The slower the drones move, the quicker they find the infection. Lower
% limit on this seems to be 0.0001 m/s. Idk if this is a fault on my part
% or not, but its consistent. Additionally, the number of the drone that
% finds the infection changes more consistently at lower speed than at higher speed
% I also didnt use the Scouting function because I found it easier to code
% it into the PathogenGrowth_2D function. We can always move it over

% One thing I cant get working in the cost function is the time detect bit.
% But I was able to get that working in the PathogenGrowth_2D function