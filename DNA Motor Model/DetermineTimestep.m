
function data = DetermineTimestep(timestep)
% Initializing inputs
n = 10;
ne = 1000;
brownianFrequency = 50;
density = 0.5;
nSpan = 8;
% Initializing input matrix
N = 10; %number of values for each variable
v = 1; %number of variables
m = 2; %number of metrics
x = 3; %number of iterations
data = zeros(N^(v-1)*x, v + m - 1 );

counter = 1;

for Kon = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,Kon,10,10,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter, 1) = speed;
    data(counter, 2) = processivity;
end

for Koff = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,Koff,10,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter, 1) = speed;
    data(counter, 2) = processivity;
end

for Kcat = logspace(-2,3,N)
    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,10,Kcat,timestep);
    speed = GetSpeed(p,t(length(t)));
    processivity = t(length(t));
    data(counter, 1) = speed;
    data(counter, 2) = processivity;
end
end








