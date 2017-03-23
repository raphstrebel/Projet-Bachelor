function [dist, duration,speed] = Distance(lat1,lon1,lat2,lon2)  

format long

KEY = 'AIzaSyAu03q9e5g6d6xqaGKaBd6PpwxVU_MP09o'; % API key for GeoCode
orig_coord = [num2str(lat1,8) ',' num2str(lon1,8)]; % Origin Coordinates
dest_coord = [num2str(lat2,8) ',' num2str(lon2,8)]; % Destination Coordinates
mode='driving'; % Mode. etc. driving, walking.
departure_time = 'now';
url = ['https://maps.googleapis.com/maps/api/distancematrix/json?origins=',orig_coord,'&destinations=',dest_coord,'&mode=',mode,'&departure_time=', departure_time,'&language=en-EN&sensor=false&key=', KEY];
str = urlread(url); % Getting the information as a JSON variable.
ST = parse_json(str); % Parsing JSON variable in order to see the lines better.
dist = ST{1}.rows{1}.elements{1}.distance.value; % Getting distance value
duration = ST{1}.rows{1}.elements{1}.duration_in_traffic.value; % Getting duration value
speed = dist/duration; % Vitesse en mètre/seconde

end