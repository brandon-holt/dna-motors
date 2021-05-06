function s = GetSpeed(p,t)
x_initial = p(1,1);
y_initial = p(1,2);
x_final = p(length(p),1);
y_final = p(length(p),2);
d = sqrt(((x_final-x_initial)^2)+((y_final-y_initial)^2));
s = d/t;
end

