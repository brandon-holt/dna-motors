function alpha = Getalpha(t,p)
tracks{1} = [t,p];    

ma = msdanalyzer(2, 'µm', 's');
ma = ma.addAll(tracks);


ma = ma.computeMSD;

ma = ma.fitLogLogMSD(0.75);

alpha = ma.loglogfit.alpha;

end


