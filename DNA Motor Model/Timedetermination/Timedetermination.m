% define N, 
N = 2; % the number of values for each variable
m = 3; % number of metrics
v = 9; % number of variables
x = 1; % number of itterations per combination of parameters
% define an matrix to save data
data = zeros(N^(v-1)*x, v + m - 1 );
%define an array for timestep
tictoc = zeros(N^(v-1)*x,1);
% nested for loop for each variable
counter = 1;
for n = round(linspace(5, 15 ,N))
    for ne = round(logspace(1, 5 ,N))
        for brownianFrequency = linspace(1, 100 ,N)
            for density = linspace(0.1, 1 ,N)
                for Spanfraction = linspace(0.8, 1 ,N)
                    nSpan = round(Spanfraction*n);
                    for Kon = logspace(-2,3,N)
                        for Koff = logspace(-2,3,N)
                            for Kcat = logspace(-2,3,N)
                                for i = 1:x
                                    tic
                                    % add in the variables from each
                                    data(counter, 1) = n;
                                    data(counter, 2) = ne;
                                    data(counter, 3) = brownianFrequency;
                                    data(counter, 4) = density;
                                    data(counter, 5) = nSpan;
                                    data(counter, 6) = Kon;
                                    data(counter, 7) = Koff;
                                    data(counter, 8) = Kcat;
                                    % call SimulateMotorDNA function
                                    [t, p] = NSimulateMotorDNA(n, ne, brownianFrequency, density, nSpan,Kon,Koff,Kcat);

                                    % calculate alpha, speed, and processivity
                                    
                                    speed = GetSpeed(p,t(length(t)));
                                    processivity = t(length(t));
                                    % calculate alpha
                                    alpha = newgetAlpha(t,p); 
                                    % add to data matrix
                                    data(counter, v ) = alpha;
                                    data(counter, v + 1) = speed;
                                    data(counter, v + 2) = processivity;

                                    % update counter
                                    counter = counter + 1;
                                    tictoc(counter) = toc;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


