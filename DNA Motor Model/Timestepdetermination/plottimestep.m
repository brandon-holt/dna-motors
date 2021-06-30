%Taking each of the results and averaging them according to whatever x is
%in the determine timestep function


%Figure 1-3 is Kon, Koff, Kcat vs speed. Figure 4-6 is Kon, Koff, Kcat vs
%processivity
x = logspace(-2,3,50);
L = 1;
counter = 1;
speed = 4;
processivity = 5;
for i = [50,100,150]
   
    y10 = ten(L:i,speed);
    figure(counter); plot(x,y10,'Color', 'blue')
    
    hold on

    y1 = one(L:i,speed);
    plot(x,y1,'Color', 'red')

    y01 = onetenth(L:i,speed);
    plot(x,y01,'Color', 'green')

    y001 = onehundreth(L:i,speed);
    plot(x,y001,'Color', 'black')
    y0001 = onethousandth(L:i,speed);
    plot(x,y0001,'Color', 'magenta')
    hold off
    L = i+1;
    counter = counter +1;
end
L = 1;
for i = [50,100,150]
   
    y10 = ten(L:i,processivity);
    figure(counter); plot(x,y10,'Color', 'blue')
    
    hold on

    y1 = one(L:i,processivity);
    plot(x,y1,'Color', 'red')

    y01 = onetenth(L:i,processivity);
    plot(x,y01,'Color', 'green')

    y001 = onehundreth(L:i,processivity);
    plot(x,y001,'Color', 'black')
    
    y0001 = onethousandth(L:i,speed);
    plot(x,y0001,'Color', 'magenta')
    hold off
    L = i+1;
    counter = counter +1;
end