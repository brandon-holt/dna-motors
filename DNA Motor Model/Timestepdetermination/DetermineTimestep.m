
function data = DetermineTimestep(timestep)
% Initializing inputs
n = 10;
ne = 1000;
brownianFrequency = 50;
density = 0.5;
nSpan = 8;
% Initializing input matrix
N = 50; %number of values for each variable
v = 3; %number of k values
m = 2; %number of outputsdata = zeros(N^(v-1)*x, v + m - 1 );
data = zeros(N*v,v+m);
counter = 1;

for Kon = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,Kon,10,10,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter,1)= Kon;
    data(counter,2) = 10; %koff
    data(counter,3) = 10;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
    
end

for Koff = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,Koff,10,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter,1)= 10; %kon
    data(counter,2) = Koff; %koff
    data(counter,3) = 10;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
end

for Kcat = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,10,Kcat,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter,1)= 10; %kon
    data(counter,2) = 10; %koff
    data(counter,3) = Kcat;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
end
end








