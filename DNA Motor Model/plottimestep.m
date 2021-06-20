x10 = ten(1:50,1);
y10 = ten(1:50,4);
plot(x10,y10,'Color', 'blue')

hold on

x1 = one(1:50,1);
y1 = one(1:50,4);
plot(x1,y1,'Color', 'red')

x0 = onetenth(1:50,1);
y0 = onetenth(1:50,4);
plot(x0,y0,'Color', 'green')

x0 = onehundreth(1:50,1);
y0 = onehundreth(1:50,4);
plot(x0,y0,'Color', 'black')
hold off