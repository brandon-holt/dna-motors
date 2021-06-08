% define N, 
N = 5; % the number of values for each variable
m = 3; % number of metrics
v = 9; % number of variables
x = 3; % number of itterations per combination of parameters
% define an matrix to save data
data = zeros(N^(v-1)*x, v + m - 1 );

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
%                                     p = p(1:100:end,:);
%                                     t = t(1:100:end,:);
                                    alpha = Getalpha(t,p); 
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


% normalization
Ndata = normalize(data);

% calculate pca
% coef = pca(data);
% pick top 2 and bottom based on feature importance
% plot relationship with 3 metrics


% For future : 

% linear regression, ridge regression, lasso regression.
% Run 3 sperate regressions pull out feature important scores, that will be
% results. 
Ndata;
X = Ndata(:,1:8);
lfit1 = fitrlinear(X,Ndata(:,9),'Regularization','lasso');
lfit2 = fitrlinear(X,Ndata(:,10),'Regularization','lasso');
lfit3 = fitrlinear(X,Ndata(:,11),'Regularization','lasso');

% fsrt test
[idx1, scores1] = fsrftest(X,Ndata(:,9));
[idx2, scores2] = fsrftest(X,Ndata(:,10));
[idx3, scores3] = fsrftest(X,Ndata(:,11));