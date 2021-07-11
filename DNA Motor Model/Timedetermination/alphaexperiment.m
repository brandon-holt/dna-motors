p1 = p(1:1000:end,:);
t1 = t(1:1000:end,:);
alpha1= Getalpha(t1,p1);

p2 = p(1:500:end,:);
t2 = t(1:500:end,:);
 

alpha2= Getalpha(t2,p2);
p3 = p(1:100:end,:);
t3 = t(1:100:end,:);

alpha3 = Getalpha(t3,p3);

p4 = p(1:50:end,:);
t4 = t(1:50:end,:);

alpha4 = Getalpha(t4,p4);