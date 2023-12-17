function [cost] = Cost(ScoutDetect,NumDrones)
%   Cost: Calculates the cost of the scouting routine
%   Inputs: ScoutDetect: Did the scouts find the pathogen or not?
%           NumDrones: Number of drones used
%           HrCost: Hourly Cost to run (per drone)
%           Daycost: Daily cost to run past penalty day (day 10)
HrCost = 100; % Dollars per day per drone
DayCost = 1000; % Dollars Per day after day 10
PenaltyDay = 10; % Start of the $1000 per day cost
% Find first successful day of scouting
day = find(sum(ScoutDetect,1)>0,1);

% If scouting was unsuccessful over 61 days, cost is maximized
if isempty(day)
    day = 61;
end

if day < PenaltyDay
    cost = NumDrones*HrCost*day;
else
    cost = NumDrones*HrCost*day + (day-PenaltyDay)*DayCost;

end