function [ bool ] = newIsMember(graph, n1, deleted_nodes)
    bool = 0;
    e = 0.00001;
    for i = 1:length(deleted_nodes)
        lat1 = graph.Nodes.Long(n1);
        lng1 = graph.Nodes.Lat(n1);
        
        lat2 = graph.Nodes.Long(deleted_nodes(i));
        lng2 = graph.Nodes.Lat(deleted_nodes(i));
       
        if(abs(lat1 - lat2) < e && abs(lng1 - lng2) < e)
            bool = 1;
        end
    end

end

