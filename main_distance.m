function [Dist, Durs ,Speed]=main_distance(Lat1,Lng1,Lat2,Lng2)


%format shortg 
curtime = clock; % year month day hour minute seconds

%while 1
%tic 

if curtime(4)>=9 && curtime(4)<20
    
    deptime = curtime(4)*60+curtime(5); % deptime: actual time in minute

    [Dist, Durs,Speed] = Distance(Lat1,Lng1,Lat2,Lng2);

end

%save(strcat(dat,'.mat')) % Horizontally concatenation
%T=toc; 
%pause(300-T) % Calculation all 5 minutes

% k = k+1;
%end



end

