function results = country_analysis(self_average, diff_average, country)

[results.self.p, results.self.table, results.self.stats] = kruskalwallis(self_average, country);
results.self.c = multcompare(results.self.stats);
results.self.eta_squared_H = calculate_effect_size_kruskal_wallis(results.self.table{2,5},length(results.self.stats.gnames),length(self_average));

[results.diff.p, results.diff.table, results.diff.stats] = kruskalwallis(diff_average, country);
results.diff.c = multcompare(results.diff.stats);
results.diff.eta_squared_H = calculate_effect_size_kruskal_wallis(results.diff.table{2,5},length(results.diff.stats.gnames),length(diff_average));

end
