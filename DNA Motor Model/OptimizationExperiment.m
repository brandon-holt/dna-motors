% define N, 
N = 3; % the number of values for each variable
m = 3; % number of metrics
v = 9; % number of variables
x = 1; % number of itterations per combination of parameters
% define an matrix to save data
data = zeros(N^v, v + m);

% nested for loop for each variable
counter = 1;
for n = linspace(2, 6 ,N)
    for ne = linspace(2, 6 ,N)
        for brownianFrequency = linspace(2, 6 ,N)
            for density = linspace(2, 6 ,N)
                for nSpan = linspace(2, 6 ,N)
                    for Kon = linspace(2,6,N)
                        for Koff = linspace(2,6,N)
                            for Kcat = linspace(2,6,N)
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
                                    alpha = Getalpha(t,p); % calculate alpha
                                    speed = GetSpeed(p,t(length(t)));
                                    processivity = t(length(t));

                                    % add to data matrix
                                    data(counter, v ) = alpha;
                                    data(counter, v + 1) = speed;
                                    data(counter, v + 2) = processivity;

                                    % update counter
                                    counter = counter + 1;
                                    toc
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


data(:,12) = [];

% calculate pca
% coef = pca(data);
% pick top 2 and bottom based on feature importance

% plot relationship with 3 metrics


% For future : 
% incorporate kon koff kcat as inputs, add the respective nested for loops.
% linear regression, ridge regression, lasso regression.
% Run 3 sperate regressions pull out feature important scores, that will be
% results. 