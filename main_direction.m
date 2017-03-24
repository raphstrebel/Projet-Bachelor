function [Path,Points,Polyline_step] = main_direction(input)

Points=[];
Path =[];
Polyline_step = [];
z=0;

for i = 1 : size(input,1)
    i
    for j = 1 : size(input,1)
        
        if i ~= j
            
            coordinates = [input(i,:);input(j,:)];
            [path,Lat,Lng,polyline_step]=Direction(coordinates);
            points = [Lng Lat];
            
            if size(Points,1)<size(points,1)
                
                Points = [[Points;zeros((size(points,1)-size(Points,1)),z)] points];
            
            elseif size(Points,1)>size(points,1)
                
                Points = [Points [points;zeros((size(Points,1)-size(points,1)),2)]];
            
            else
                
                Points = [Points points];
            
            end
          
            
            if size(Path,1)<size(path,1)
                
                Path = [[Path;zeros((size(path,1)-size(Path,1)),z)] path];
            
            elseif size(Path,1)>size(path,1)
                
                Path = [Path [path;zeros((size(Path,1)-size(path,1)),2)]];
            
            else
                
                Path = [Path path];
            
            end
            
            if size(Polyline_step,1)<size(polyline_step,1)
                
                Polyline_step = [[Polyline_step;zeros((size(polyline_step,1)-size(Polyline_step,1)),z)] polyline_step];
            
            elseif size(Polyline_step,1)>size(polyline_step,1)
                
                Polyline_step = [Polyline_step [polyline_step;zeros((size(Polyline_step,1)-size(polyline_step,1)),2)]];
            
            else
                
                Polyline_step = [Polyline_step polyline_step];
            
            end
            
            z=z+2;
            
        end
        
    end
    
end   
    
end


