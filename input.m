function [input] = input(center_lat,center_lng,types,radius)

format long

input_lat = [];
input_lng = [];
KEY = 'AIzaSyCSF1C2kkTxT_oIelEe4_crkxuTEv6n67s'; % API key for GeoCode
location = [num2str(center_lat) ',' num2str(center_lng)];
url = ['https://maps.googleapis.com/maps/api/place/radarsearch/json?location=',location,'&radius=',radius,'&types=',types,'&key=',KEY];
str = urlread(url); % Getting the information as a JSON variable.
ST = parse_json(str); % Parsing JSON variable in order to see the lines better.

for i = 1:numel(ST{1,1}.results)
lat = ST{1,1}.results{1,i}.geometry.location.lat;
lng = ST{1,1}.results{1,i}.geometry.location.lng;
input_lat = [input_lat;lat];
input_lng = [input_lng;lng];
end

input = [input_lat input_lng];

end

