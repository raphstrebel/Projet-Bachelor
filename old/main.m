clc
clear all

%% Fix the road

%Input of the code

% center_lat = 48.858336; % Center of the search
% center_lng = 2.342377; % Center of the search
% types='subway_station'; % Type of search
% radius = '4000'; % Radius of the search.
% 
% [input] = input(center_lat,center_lng,types,radius);
% 
% i=1;
% 
% while i <= length(input)
% j=1;    
%     while j <= length(input)
%         
%         if i ~= j
%         dist = gedistance(input(i,2),input(i,1),input(j,2),input(j,1));
%         
%         if dist < 1000
%             j
%             i
%         input(j,:) = [];    
%         end
%             
%         end
%     j = j+1;
%     end
%     
% i = i + 1;   
% end
% 
% plot(input(:,2),input(:,1),'.r','MarkerSize',20)
% 
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)
% hold off
%   
% [Path,Points,Polyline_step] = main_direction(input);
% 
% save('Distance_input','input','Path','Points','Polyline_step');

%% Round the coordinates

% load('Distance_input');
% 
% format long g
% 
% Path = round(Path*10^5)/10^5;
% Points = round(Points*10^5)/10^5;
% Polyline_step = round(Polyline_step*10^5)/10^5;
% 
% save('Distance_input_round5','input','Path','Points','Polyline_step');


%% Plot the graph

% load('Distance_input_round5');
% 
%  figure(1)
%  
%  plot(input(:,2),input(:,1),'.r','MarkerSize',20)
%  hold on
% 
%  for f = 1:2:(size(Path,2)-1)
%  M=Points(:,f:f+1);   
%  index=find(M(:,1));     
%  N=M(index,:);
%  plot(N(:,1),N(:,2),'xk')
%  hold on
%  O=Path(:,f:f+1);   
%  index=find(O(:,1));     
%  P=O(index,:);
%  plot(P(:,2),P(:,1),'k','linewidth',1.5)
%  hold on
%  end
%  
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)
% hold off

%% Connect to the Database

% conn = database('cyp','postgres','GeMenEliCyp54','org.postgresql.Driver','jdbc:postgresql://localhost:5432/cyp');
% sqlquery = 'select * from roads_cut_vertices_pgr';
% curs = exec(conn,sqlquery);
% curs = fetch(curs);
% Data = curs.Data;
% Lng = Data(:,7);
% Lng2 = cell2mat(Lng);
% Lat = Data(:,8);
% Lat2 = cell2mat(Lat);
% Nodes = [Lat2 Lng2];
% 
% save('Graph','Nodes');
% 
% plot(Nodes(:,2),Nodes(:,1),'x')
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)

%% Take off nodes out of the perimeter / only if the periph is not use

% Mindist = [];
% idx = [];
% 
% for i = 1:length(Nodes)
% if gedistance(Nodes(i,1),Nodes(i,2),48.858336,2.342377) < 2500 % remplacer après les inputs de main
% idx(i) = 1;
% end
% end 
% Nodes_Perimeter = Nodes(find(idx),:);

% save('Graph','Nodes','Nodes_Perimeter');

% plot(Nodes_Perimeter(:,2),Nodes_Perimeter(:,1),'x')
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)

%% Take off nodes which does not match the shortest paths / 1run

% load('Distance_input_round5');
% load('Graph');
% 
% idx2 = zeros(length(Nodes),1);
% 
% for k = 1 : length(Nodes) % Nodes_Perimeter
% exit = 0;
% k
% for i = 1:2:(size(Path,2)-1)
%     
% P = Path(find(Path(:,i)),i:i+1);
% 
% for j = 1:length(P)
% 
% if gedistance(Nodes(k,1),Nodes(k,2),P(j,1),P(j,2)) <= 7 % Nodes_Perimeter
%     idx2(k) = 1;
%     exit = 1;
%     break
% end
% end
% if exit
%     break
% end
% end
% k
% end
% 
% Nodes_Reseau = Nodes(find(idx2),:);
% 
% save('Graph','Nodes','Nodes_Reseau'); % Nodes_Perimeter
% 
% plot(Nodes_Reseau(:,2),Nodes_Reseau(:,1),'.r',10)
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)

%% Take off nodes which does not match the shortest paths / different runs

% load('Distance_input_round5');
% load('Graph');
% 
% Nodes_Perimeter = Nodes(14000:length(Nodes),:); % Indiquer fragmentation ici
% 
% idx2 = zeros(2,1);
% 
% for k = 1 : length(Nodes_Perimeter) % Nodes_Perimeter
% exit = 0;
% k
% for i = 1:2:(size(Path,2)-1)
%     
% P = Path(find(Path(:,i)),i:i+1);
% 
% for j = 1:length(P)
% 
% if gedistance(Nodes_Perimeter(k,1),Nodes_Perimeter(k,2),P(j,1),P(j,2)) <= 7 % Nodes_Perimeter
%     idx2(k) = 1;
%     exit = 1;
%     break
% end
% end
% if exit
%     break
% end
% end
% k
% end
% 
% Nodes_Reseau1 = Nodes_Perimeter(find(idx2),:); % Nodes_Perimeter
% 
% save('Graph','Nodes','Nodes_Perimeter','Nodes_Reseau1'); % Nodes_Perimeter
% 
% plot(Nodes_Reseau(:,2),Nodes_Reseau(:,1),'.r',10)
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)


%% Create Adjacency Matrix -> 1 if connection between nodes, 0 otherwise

% load('Graph')
% load('Distance_input_round5')
% 
% AM = zeros(length(Nodes_Reseau));
% 
% Path = Path(:,1:100); % a supprimer !!!!!
% 
% 
% for w = 1:2:(size(Path,2)-1)
% w
% P = Path(find(Path(:,1)),w:w+1);
% test = [0 0];
% k=1;
% count = 0;
% t=0;
% tt = 0;
% while k <= length(P) 
% 
% for i = 1:length(Nodes_Reseau)
% 
% if gedistance(P(k,1),P(k,2),Nodes_Reseau(i,1),Nodes_Reseau(i,2)) < 7
%     test = Nodes_Reseau(i,:);
% 
%     while k+1 <= length(P)
% 
%     for z = 1:length(Nodes_Reseau)
%         
%     if gedistance(P(k+1,1),P(k+1,2),Nodes_Reseau(z,1),Nodes_Reseau(z,2)) < 7 && (Nodes_Reseau(z,1) ~= test(1,1)) && (Nodes_Reseau(z,2) ~= test(1,2))
% 
%     if count == 0    
%     AM(i,z) = 1;
%     t=i;
%     else
%         if z ~= tt
%         AM(t,z) = 1;
%         else
%         AM(tt,t) = 0;
%         end
%     end
%     test = Nodes_Reseau(z,:);
%     count = count + 1;
%     tt = t;
%     t = z;
%     break
%         
%     end
%     
%     end
%     k=k+1;
%     end
%     
% end
% 
% end
% 
% k=k+1;
% end
% 
% end

% Nodes_Reseau = [Nodes_Reseau(:,2) Nodes_Reseau(:,1)];

% gplot(AM,Nodes_Reseau,'k')

% save('Graph','Nodes','Nodes_Perimeter','Nodes_Reseau','AM');

%% Create graph

% load('Graph')
% load('Distance_input_round5')
% 
% graph = digraph(AM);
% Nodes_Reseau = [Nodes_Reseau(:,2) Nodes_Reseau(:,1)];
% 
% graph.Nodes.Long = Nodes_Reseau(:,1);
% graph.Nodes.Lat = Nodes_Reseau(:,2);
% 
% weak_bins = conncomp(graph,'Type','weak');
% G = rmnode(graph,find(weak_bins~=1));
%  
% save('Graph','Nodes','Nodes_Perimeter','Nodes_Reseau','AM','graph','G');
%% Calculate Speed every 5 minutes

% load('Graph')
% 
% n = 1;
% 
% while 1
% tic 
% 
% format shortg 
% curtime = clock; 
% deptime=strcat(num2str(curtime(2),'%02i'), num2str(curtime(3),'%02i'),num2str(curtime(4),'%02i'),num2str(curtime(5),'%02i'));
% 
% S(n).graph = G;
% S(n).name = deptime;
% 
% if curtime(4)>=9 && curtime(4)<20
% 
% for i = 1:size(G.Edges.EndNodes,1)
% i
% format long
% Lat1 = G.Nodes{G.Edges.EndNodes(i,1),1};
% Lng1 = G.Nodes{G.Edges.EndNodes(i,1),2};
% Lat2 = G.Nodes{G.Edges.EndNodes(i,2),1};
% Lng2 = G.Nodes{G.Edges.EndNodes(i,2),2};
% 
% [Dist,Durs,Speed] = Distance(Lat1,Lng1,Lat2,Lng2);
% 
% S(n).graph.Edges.Weight(i,1)=Speed;
% S(n).graph.Edges.Dist(i,1)=Dist;
% S(n).graph.Edges.Durs(i,1)=Durs;
% 
% end
% n = n + 1;
% save('Graph','Nodes','Nodes_Perimeter','Nodes_Reseau','AM','graph','G','S');
% end
% 
% T=toc; 
% pause(100-T)
% 
% 
% 
% end

%% Plot Graph
clc
load('Graph')

% h = plot(S(1).graph,'XData',S(1).graph.Nodes.Long,'YData',S(1).graph.Nodes.Lat,'EdgeColor','k');
% 
% H = reshape((S(1).graph.Edges{find(S(1).graph.Edges.Weight<3),1})',1,[]);
% 
% highlight(h,H,'EdgeColor','r','LineWidth',2.5)
% 
% plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)


eps = 0.0001; % à discuter, combien de difference entre long et lat de deux points on accepte

delete_nodes = []; % On initialize la liste des noeuds enlevés

%fprintf('number of nodes : %d',numnodes(graph))

%plot(graph,'XData',graph.Nodes.Long,'YData',graph.Nodes.Lat)

numnodes(graph)

% Pour tous les noeuds dans graph
for n1 = numnodes(graph):-1:1
    if(n1 == 1)
        break;
    end
    
    while(ismember(n1, delete_nodes) == 1)
       n1 = n1 - 1;
    end
    
    lat1 = graph.Nodes.Long(n1);
    lng1 = graph.Nodes.Lat(n1);
    succ = successors(graph, n1);
    succDegreeOne = [];
    
    % Compute in and out degree of every successor of n1
    for j = 1:size(succ)
        out_d = outdegree(graph,succ(j));
        in_d = indegree(graph,succ(j));
        if out_d == 1 && in_d == 1
            succDegreeOne = [succDegreeOne, succ(j)];
        end
    end
    %fprintf('successors of degree 1 of %d\n', n1)
    %succDegreeOne
    % Keep only nodes of out degree 1
    for k = 1:size(succDegreeOne)
        
        n2 = succDegreeOne(k);
        %fprintf('successors of degree 1 of %d\n', n2)
        lat2 = graph.Nodes.Long(n2);
        lng2 = graph.Nodes.Lat(n2);
        
        % n3 is the successor of n2
        n3 = successors(graph, n2);
        
        %fprintf('successors of node 2: %d\n', n3)
        
        lat3 = graph.Nodes.Long(n3);
        lng3 = graph.Nodes.Lat(n3);
    
        % Compute function of line passing through n1 and n3
%         coefficients = polyfit([lat1, lat3], [lng1, lng3], 1);
%         a = coefficients (1);
%         b = coefficients (2);
        
        % Compute distance between n2 and line (n1,n3)
        coordNode1 = [lat1; lng1; 0];
        coordNode3 = [lat3; lng3; 0];
        coordNode2 = [lat2; lng2; 0];
        
        
        a = coordNode1 - coordNode3;
        b = coordNode2 - coordNode3;
        
        if(norm(a) == 0)
            dist = 0;
        else
            dist = norm(cross(a,b)) / norm(a);
        end
        
        %fprintf('distance ')
        %dist
        
        % Point 2 is at acceptable distance from line n1-n3
        if(dist < eps)
            %fprintf('distance is < to eps\n')
            % If there is no edge n1->n3 we add it
            if(findedge(graph,n1,n3) == 0)
                %fprintf('edge does not exist %d %d %d\n', n1, n2, n3)
                graph = addedge(graph,n1,n3,1);
            end
            
            % Delete node n2
            %fprintf('DELETE %d', n2)
            graph = rmnode(graph, n2);
            
            % Matlab rmnode function reindexes the vertices with index above
            % n2 (by -1) so we need to adjust delete_nodes
            
            for d = 1:size(delete_nodes)
                if(delete_nodes(d) > n2)
                    delete_nodes(d) = delete_nodes(d) - 1;
                end
            end
            delete_nodes = [delete_nodes n2];
        end
    end
    plot(graph,'XData',graph.Nodes.Long,'YData',graph.Nodes.Lat)
end

numnodes(graph)
        
        
%     % Pour tous les successeurs de n1
%     for j = 1:size(succ)
%         j
%         n2 = succ(j);
%         lat2 = graph.Nodes.Long(n2);
%         lng2 = graph.Nodes.Lat(n2);
%         
%         % delete n2 = 1
%         to_delete = 1;
%         
%         % On vérifie que la différence des longitudes et des latitudes
%         % est < a eps
%         if(abs(lat1 - lat2) < eps || abs(lng1 - lng2) < eps)
%             
%             % Liste des successeurs de n1
%             nextsucc = successors(graph, n2);
%         
%             % Pour tous les successeurs de n2 
%             for k = 1:size(nextsucc)
%                 k
%                 n3 = nextsucc(k);
%                 lat3 = graph.Nodes.Long(n3);
%                 lng3 = graph.Nodes.Lat(n3);
% 
%                 % Si la différence des longitudes et des latitudes
%                 % est > a eps on ne doit pas delete n2 
%                 if(abs(lat2 - lat3) > eps && abs(lng2 - lng3) > eps)
%                     fprintf('difference > eps')
%                     to_delete = 0;
%                 end
%             end
%             % Tous les successeurs de n2 sont sur un ligne "droite"
%             if(to_delete == 1)
%             % Si il n'existe pas de edge n1 -> n3 on l'ajoute
%                 if(findedge(graph,n1,n3) ~= 0)
%                     graph = addedge(graph,n1,n3,1);
%                 end
%                 % On ajoute n2 à la liste des noeuds à enlever
%                 delete_nodes = [delete_nodes, n2];
%             end
%                 
%         end
%     end
% end
% 
% % On enlève les noeuds dans la liste delete_nodes 
% for n = 1:size(delete_nodes)
%     fprintf('difference > eps')
%     graph = rmnode(graph, delete_nodes(n));
% end
% 
% %fprintf('number of nodes : %d',numnodes(graph))

% h1 = plot(graph,'XData',graph.Nodes.Long,'YData',graph.Nodes.Lat,'EdgeColor','k');
% 
% % plot_google_map
% ylabel({'$\phi$ [degrees]'},'interpreter','latex','FontSize',15)
% xlabel({'$\lambda$ [degrees]'},'interpreter','latex','FontSize',15)
% hold off