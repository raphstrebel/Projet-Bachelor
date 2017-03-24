function [path,Lat,Lng,polyline_step] = Direction(coordinates)

format long

path = [];
Lat = [];
Lng = [];
polyline_step = [];

KEY = 'AIzaSyBpjU8mnzq_m7ABcT21nOdt0gkooUlS3I0'; % API key for GeoCode
orig_coord = [num2str(coordinates(1,1)) ',' num2str(coordinates(1,2))]; % Origin Coordinates
dest_coord = [num2str(coordinates(2,1)) ',' num2str(coordinates(2,2))]; % Destination Coordinates
mode='driving'; % Mode. etc. driving, walking.
departure_time = '1502240400';

url = ['https://maps.googleapis.com/maps/api/directions/json?origin=',orig_coord,'&destination=',dest_coord,'&mode=',mode,'&departure_time=', departure_time,'&language=en-EN&sensor=false&key=', KEY];

str = urlread(url); % Getting the information as a JSON variable.

ST = parse_json(str); % Parsing JSON variable in order to see the lines better.

for i = 1:numel(ST{1,1}.routes{1,1}.legs{1,1}.steps)

lat = ST{1,1}.routes{1,1}.legs{1,1}.steps{1,i}.end_location.lat;
lng = ST{1,1}.routes{1,1}.legs{1,1}.steps{1,i}.end_location.lng;

Lat = [Lat;lat];
Lng = [Lng;lng];

asciiIn = ST{1,1}.routes{1,1}.legs{1,1}.steps{1,i}.polyline.points;
offset=0;

[latOut,lonOut] = googlePolyLineDecoder(asciiIn,offset);

sub_path = [latOut',lonOut'];

path = [path;sub_path];

if i == 1
    step = [sub_path(1,:);sub_path(end,:)];
else
    step = sub_path(end,:);
end

polyline_step = [polyline_step;step];

end

lat1 = ST{1,1}.routes{1,1}.legs{1,1}.steps{1,1}.start_location.lat;
lng1 = ST{1,1}.routes{1,1}.legs{1,1}.steps{1,1}.start_location.lng;

Lat = [lat1;Lat];
Lng = [lng1;Lng];

end