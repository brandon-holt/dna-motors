% define N, 
N = 3; % the number of values for each variable
m = 3; % number of metrics
v = 5; % number of variables

% define an matrix to save data
data = zeros(N^v, v + m);

% nested for loop for each variable
counter = 1;
for n = linspace(2, 20 ,N)
    for ne = linspace(2, 20 ,N)
        for n = linspace(2, 20 ,N)
            for n = linspace(2, 20 ,N)
                for n = linspace(2, 20 ,N)
                    % add in the variables from each
                    data(counter, 1) = n;
                    data(counter, 2) = ne;
                    
                    % call SimulateMotorDNA function
                    [t, p] = SimulateMotorDNA(n, ne, brownianFrequency, density, nSpan);
                    
                    % calculate alpha, speed, and processivity
                    alpha = []; % calculate alpha
                    speed = [];
                    processivity = [];
                    
                    % add to data matrix
                    data(counter, v + 1) = alpha;
                    data(counter, v + 2) = speed;
                    data(counter, v + 3) = processivity;
                    
                    % update counter
                    counter = counter + 1;
                end
            end
        end
    end
end

% calculate pca

% pick top 2 and bottom based on feature importance

% plot relationship with 3 metrics

