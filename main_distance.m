function [Durs2]=main_distance(latlong)

Durs2=[];
Speed2=[];


k = 1;
dat = '410';
prevday=27;

while 1
tic 

format shortg 
curtime = clock; % year month day hour minute seconds


if curtime(4)>=9 && curtime(4)<20
    
    deptime = curtime(4)*60+curtime(5); % deptime: actual time in minute

    [Dist, Durs,Speed] = Duration(latlong);
    Durs2 = [Durs2 [deptime*ones(1,size(Durs,2)); Durs]];
    Speed2 = [Speed2 [deptime*ones(1,size(Speed,2)); Speed]];

end

save(strcat(dat,'.mat')) % Horizontally concatenation
T=toc; 
pause(300-T) % Calculation all 5 minutes


if prevday ~= curtime(3) % Change the day
    dat = strcat(num2str(curtime(3)), num2str(curtime(2),'%02i')); % if we are 1 mars: 103
    Durs = [];
end
  
prevday = curtime(3);
k = k+1;
end



end

