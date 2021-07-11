function alpha = Getalpha(t,p)
% if length(t) > 10000
%      p = p(1:100:end,:);
%      t = t(1:100:end,:);
% elseif length(t) > 1000
%      p = p(1:10:end,:);
%      t = t(1:10:end,:);
% end


tracks{1} = [t,p]; 

ma = msdanalyzer(2, 'µm', 's');
ma = ma.addAll(tracks);


ma = ma.computeMSD;

ma = ma.fitLogLogMSD(0.25);

alpha = ma.loglogfit.alpha;

end


