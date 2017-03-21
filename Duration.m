function [Dist, Durs,Speed] = Duration(latlong)

%dist = zeros(size(latlong,1)-1,1); % initialization dist: matrix 0, size number of distance to calculate
%durs = zeros(size(latlong,1)-1,1);
%speed = zeros(size(latlong,1)-1,1);% initialization durs: matrix 0, size number of distance to calculate
Dist=[];
Durs=[];
Speed = [];

for j=1:2:(size(latlong,2)-1)

% For each of the city, find the travelling time between two cities.
for i=2:size(latlong,1) % calculation of duration and distance between 2 points
    
    if latlong(i-1,j) ~= 0 && latlong(i,j) ~= 0
    [dist(i-1),durs(i-1),speed(i-1)]=Distance(latlong(i-1,j+1),latlong(i-1,j),latlong(i,j+1),latlong(i,j));
    else
    dist(i-1)=0;
    durs(i-1)=0;
    speed(i-1)=0;
    end
    
end

Dist=[Dist dist];
Durs=[Durs durs];
Speed=[Speed speed];

end


end

