clc
clear all

%% Fix the road

% Input of the code
center_lat = 48.858336; % Center of the search
center_lng = 2.342377; % Center of the search
types='subway_station'; % Type of search
radius = '1500'; % Radius of the search.

[input] = input(center_lat,center_lng,types,radius);
  
[Path,Points,Polyline_step] = main_direction(input);

save('Distance_input','input','Path','Points','Polyline_step');
clear all
clc

%% Plot the graph

load('Distance_input');

 figure(1)
 
 plot(input(:,2),input(:,1),'.r','MarkerSize',20)
 hold on
 
 for f = 1:2:(size(Path,2)-1)
 M=Points(:,f:f+1);   
 index=find(M(:,1));     
 N=M(index,:); 
 plot(N(:,1),N(:,2),'xk')
 hold on
 O=Path(:,f:f+1);   
 index=find(O(:,1));     
 P=O(index,:);
 plot(P(:,2),P(:,1),'k','linewidth',1.5)
 hold on
 end
 
plot_google_map
ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)
hold off

%% Calculate Speed

% [Durs2] = main_distance(Points);