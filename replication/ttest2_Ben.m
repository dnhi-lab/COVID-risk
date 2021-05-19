function results = ttest2_Ben(var, type1, type2)

[~, results.p, ~, results.stats]    = ttest2(var(type1), var(type2), 'Vartype', 'unequal');
results.d                           = computeCohen_d(var(type1), var(type2), 'independent');

end
