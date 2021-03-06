% just finished running OptimizationExperiment.m or loaded results from
% results folder
close all; 

% plotting high dimensional data
figure;
gplotmatrix(Ndata(:,1:8), Ndata(:,9:11), ones(length(Ndata),1));

% plotting feature importance
figure;
lfits = {lfit1, lfit2, lfit3};
titles = {'Alpha', 'Speed', 'Processivity'};
labels = categorical({'Valency','No. Enzymes','Brownian Frequency','Density', 'Span', 'Kon', 'Koff', 'Kcat'});
for i = 1:3
    subplot(1,3,i); bar(labels, lfits{i}.Beta);
    title(titles{i}); ylabel('Feature Importance (Beta)');
end

% highest speed has low processivity try combination of both variables
figure; scatter(Ndata(:,10), Ndata(:,11)); xlabel('Speed'); 
speedProcessivity = sqrt(Ndata(:,10).^2 + Ndata(:,11).^2);
hold on; scatter(Ndata(:,10), speedProcessivity); xlabel('Speed');
legend('Processivity', 'Speed + Processivity');
lfit4 = fitrlinear(X,speedProcessivity,'Regularization','lasso');
figure; bar(labels, lfit4.Beta);