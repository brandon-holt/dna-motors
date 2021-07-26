function alpha = newgetAlpha(t,p)
MSD = zeros(length(t)-1,2);
for lagtime = 1:(length(t)-1)
    SDval = zeros(length(t)-lagtime,1);
    for positionindx = 1:(length(t)-lagtime)
        x1 = p(positionindx,1);
        x2 = p(lagtime+positionindx,1);
        y1 = p(positionindx,2);
        y2 = p(lagtime+positionindx,2);
        displacement = (x2-x1)^2 + (y2-y1)^2;
        SDval(positionindx) = displacement;
    end
    MSD(lagtime,1) = mean(SDval);
    MSD(lagtime,2) = t(lagtime);
end
x = log(MSD(2:round(0.25*length(MSD(:,2))),2));
y = log(MSD(2:round(0.25*length(MSD(:,1))),1));

p = polyfit(x, y, 1);
alpha = p(1);
end