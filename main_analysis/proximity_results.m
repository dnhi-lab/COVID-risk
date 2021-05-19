function results = proximity_results(self_average,diff_average, influences)

results.infect_direct.self    = ttest2_Ben(self_average, influences.infect_direct{3}    == 0, influences.infect_direct{3}   > 0);
results.infect_indirect.self  = ttest2_Ben(self_average, influences.infect_indirect{3}  == 0, influences.infect_indirect{3} > 0);
results.death.self            = ttest2_Ben(self_average, influences.death{3}            == 0, influences.death{3}           > 0);
results.infect_direct.diff    = ttest2_Ben(diff_average, influences.infect_direct{3}    == 0, influences.infect_direct{3}   > 0);
results.infect_indirect.diff  = ttest2_Ben(diff_average, influences.infect_indirect{3}  == 0, influences.infect_indirect{3} > 0);
results.death.diff            = ttest2_Ben(diff_average, influences.death{3}            == 0, influences.death{3}           > 0);

end
