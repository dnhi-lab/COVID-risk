function results = stress_finances_corrs(get_COVID, infect_others, severe_symptoms, var)

results.get_COVID_abs                = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         var);
results.get_COVID_rel                = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         var);
results.infect_others_abs            = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     var);
results.infect_others_rel            = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     var);
results.severe_symptoms_abs          = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   var);
results.severe_symptoms_rel          = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   var);

end
