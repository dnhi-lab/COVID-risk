function r = health_analysis(self_average, diff_average, health)

excl_v_bad = health.self{3} ~= 0;

% Absolute risk perception (risk for self)
[r.self.p, r.self.table, r.self.stats] = kruskalwallis(self_average(excl_v_bad), health.self{3}(excl_v_bad));
r.self.c = multcompare(r.self.stats);
r.self.eta_squared_H = calculate_effect_size_kruskal_wallis(r.self.table{2,5},length(r.self.stats.gnames),length(self_average(excl_v_bad)));

% Relative risk perception (optimism bias; other-self)
[r.diff.p, r.diff.table, r.diff.stats] = kruskalwallis(diff_average(excl_v_bad), health.self{3}(excl_v_bad));
r.diff.c = multcompare(r.diff.stats);
r.diff.eta_squared_H = calculate_effect_size_kruskal_wallis(r.diff.table{2,5},length(r.diff.stats.gnames),length(self_average(excl_v_bad)));

end
