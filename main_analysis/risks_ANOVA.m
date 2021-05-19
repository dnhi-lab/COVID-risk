function results = risks_ANOVA(self, othe, column)

results.anova = ANOVA_person_time(self, othe, column);
results.anova.SS_person              = results.anova.table{2,2};
results.anova.SS_time                = results.anova.table{3,2};
results.anova.SS_person_time         = results.anova.table{5,2};
results.anova.SS_error               = results.anova.table{8,2};
results.anova.p_eta_squ_person       = partial_eta_squared(results.anova.SS_person,       results.anova.SS_error);
results.anova.p_eta_squ_time         = partial_eta_squared(results.anova.SS_time,         results.anova.SS_error);
results.anova.p_eta_squ_person_time  = partial_eta_squared(results.anova.SS_person_time,  results.anova.SS_error);

end
