
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
m = 2; %number of outputs 
x = 5; % number of repetitions per set of parameters
data = zeros(N*v,v+m);
counter = 1;

for Kon = logspace(-2,3,N)
    preavgsv = zeros(m,x);
    internalcounter = 1;
    for i = 1:x
        [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,Kon,10,10,timestep);
        preavgspeed = GetSpeed(p,t(length(t)));
        preavgprocessivity = t(length(t));
        preavgsv(internalcounter,1) = preavgspeed;
        preavgsv(internalcounter,2)= preavgprocessivity;
        internalcounter = internalcounter +1;
    end
    speed = mean(preavgsv(:,1));
    processivity = mean(preavgsv(:,2));
    data(counter,1)= Kon;
    data(counter,2) = 10; %koff
    data(counter,3) = 10;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
   
    
end

for Koff = logspace(-2,3,N)
    preavgsv = zeros(m,x);
    internalcounter = 1;
    for i = 1:x
        [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,Koff,10,timestep);
        preavgspeed = GetSpeed(p,t(length(t)));
        preavgprocessivity = t(length(t));
        preavgsv(internalcounter,1) = preavgspeed;
        preavgsv(internalcounter,2)= preavgprocessivity;
        internalcounter = internalcounter +1;
    end
    speed = mean(preavgsv(:,1));
    processivity = mean(preavgsv(:,2));
    data(counter,1)= 10; %kon
    data(counter,2) = Koff; %koff
    data(counter,3) = 10;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
   
end

for Kcat = logspace(-2,3,N)
    preavgsv = zeros(m,x);
    internalcounter = 1;
    for i = 1:x
        [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,10,10,Kcat,timestep);
        preavgspeed = GetSpeed(p,t(length(t)));
        preavgprocessivity = t(length(t));
        preavgsv(internalcounter,1) = preavgspeed;
        preavgsv(internalcounter,2)= preavgprocessivity;
        internalcounter = internalcounter +1;
    end
    speed = mean(preavgsv(:,1));
    processivity = mean(preavgsv(:,2));
    data(counter,1)= 10; %kon
    data(counter,2) = 10; %koff
    data(counter,3) = Kcat;  %kcat
    data(counter, 4) = speed;
    data(counter, 5) = processivity;
    counter = counter + 1;
end

end







