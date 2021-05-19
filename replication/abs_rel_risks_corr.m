function results = abs_rel_risks_corr(self,diff, corr_var)

[results.self.rho, results.self.pval] = corr(corr_var, self);
[results.diff.rho, results.diff.pval] = corr(corr_var, diff);

end
