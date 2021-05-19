function results = compare_risks(var1,var2, var3)

results = ANOVA_compare_riskPerceptions(var1, var2, var3);
results.SS_question            = results.table{2,2};
results.SS_error               = results.table{4,2};
results.p_eta_squ_person       = partial_eta_squared(results.SS_question, results.SS_error);

end
