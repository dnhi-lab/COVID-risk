%% COVID main analysis
% This is a script for the results reported in our COVID paper. First 
% create the variables, each line thereafter can be run indepedently of all
% others. Every result report in the paper is a separate line in this 
% script, such that you can easily find the line that creates a specific 
% result

clear
cd('C:\Users\kuper\Desktop\Covid_study_2020_06_21\00_Submission_Royal_Society_Open_Science\Analysis_final')
load('data_within_v7.mat')

%% Create the variables
[get_COVID, infect_others, severe_symptoms, place, influences, consequ, other, demo, country] = create_variables(data_all);

%% 3.1: Absolute and relative risk perception
% Get COVID
% Descriptives
results.get_COVID.mean_4_horizons           = results_mean_risks(   get_COVID.self,5);
results.get_COVID.mean_lifetime             = results_mean_risks(   get_COVID.self,4);
% Test preregistered hypothesis 1
[~, results.get_COVID.H1.p, ~, results.get_COVID.H1.stats] = ttest( get_COVID.self{2}(:,1),         get_COVID.othe{2}(:,1));
results.get_COVID.H1.d                      = computeCohen_d(       get_COVID.self{2}(:,1),         get_COVID.othe{2}(:,1),         'paired');
% Run an ANOVA to test effects for all time points
results.get_COVID                           = risks_ANOVA(          get_COVID.self,                 get_COVID.othe, 5);
% Test preregistered hypothesis 2
[~, results.get_COVID.H2.p, ~, results.get_COVID.H2.stats] = ttest( get_COVID.diff{1}(:,1),         get_COVID.diff{2}(:,1));
results.get_COVID.H2.d                      = computeCohen_d(       get_COVID.diff{1}(:,1),         get_COVID.diff{2}(:,1),         'paired');

% Infect Others
% Descriptives
results.infect_others.mean_6_contexts       = results_mean_risks(   infect_others.self,7);
% Test preregistered hypothesis 1
[~, results.infect_others.H1.p, ~, results.infect_others.H1.stats] = ttest(infect_others.self{2}(:,7), infect_others.othe{2}(:,7));
results.infect_others.H1.d                  = computeCohen_d(       infect_others.self{2}(:,7),     infect_others.othe{2}(:,7),     'paired');
% Run an ANOVA to test effects for all time points
results.infect_others                       = risks_ANOVA(          infect_others.self,             infect_others.othe,             7);
% Test preregistered hypothesis 2
[~, results.infect_others.H2.p, ~, results.infect_others.H2.stats] = ttest(infect_others.diff{1}(:,7), infect_others.diff{2}(:,7));
results.infect_others.H2.d                  = computeCohen_d(       infect_others.diff{1}(:,7),     infect_others.diff{2}(:,7),     'paired');

% Severe Symptoms
% Run an ANOVA to test effects for all time points
results.severe_symptoms                     = risks_ANOVA(          severe_symptoms.self,           severe_symptoms.othe,           1);

% Comparing optimism biases
% One-way repeated-designs ANOVA to compare whether there are differences between the 3
% biases, and post-hoc comparisons to test which is different from which
results.compare_COVID_risks                 = compare_risks(        get_COVID.diff_average,         infect_others.diff_average,     severe_symptoms.diff_average);
% One-way ANOVA to compare control optimism bias questions
results.compare_control_risks               = compare_risks(        influences.flu.diff_average,    influences.std.diff_average,    influences.bone.diff_average);

% Optimism bias and time horizon for Get COVID
[results.get_COVID.optimism_time_horizon.p, results.get_COVID.optimism_time_horizon.table, results.get_COVID.optimism_time_horizon.stats] = anova1(get_COVID.diff_time_horizon_averages_mat);
results.get_COVID.optimism_time_horizon.c   = multcompare(          results.get_COVID.optimism_time_horizon.stats);
results.get_COVID.optimism_time_horizon.p_eta_squ = partial_eta_squared(results.get_COVID.optimism_time_horizon.table{2,2}, results.get_COVID.optimism_time_horizon.table{3,2});

% Optimism bias and social context for Infect Others
[results.infect_others.optimism_social_context.p, results.infect_others.optimism_social_context.table, results.infect_others.optimism_social_context.stats] = anova1(infect_others.diff_social_context_averages_mat);
results.infect_others.optimism_social_context.c = multcompare(results.infect_others.optimism_social_context.stats);
results.infect_others.optimism_social_context.p_eta_squ = partial_eta_squared(results.infect_others.optimism_social_context.table{2,2}, results.infect_others.optimism_social_context.table{3,2});

% People who live with family:
results.other.live_w_family                 = ((sum(other.living_situation{3}(:,2) == 1 | other.living_situation{3}(:,3) == 1 | other.living_situation{3}(:,4) == 1))/length(other.living_situation{3}))*100;

% How much did different people do to prevent infection?
[results.other.how_much_did_do.p, results.other.how_much_did_do.table, results.other.how_much_did_do.stats] = anova1(other.how_much_did_do.diff{3});
results.other.how_much_did_do.c             = multcompare(results.other.how_much_did_do.stats);
results.other.how_much_did_do.p_eta_squ = partial_eta_squared(results.other.how_much_did_do.table{2,2}, results.other.how_much_did_do.table{3,2});

%% 3.2: Potential influences of risk perception
% Age
results.age_get_COVID                       = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         demo.age{1});
results.age_infect_others                   = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     demo.age{1});
results.age_severe_symptoms                 = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   demo.age{1});

% Gender
results.gender_get_COVID                    = gender_analysis(      get_COVID.self_average,         get_COVID.diff_average,         demo);
results.gender_infect_others                = gender_analysis(      infect_others.self_average,     infect_others.diff_average,     demo);
results.gender_severe_symptoms              = gender_analysis(      severe_symptoms.self_average,   severe_symptoms.diff_average,   demo);

% Overall health
results.health_get_COVID                    = health_analysis(      get_COVID.self_average,         get_COVID.diff_average,         influences.health);
results.health_infect_others                = health_analysis(      infect_others.self_average,     infect_others.diff_average,     influences.health);
results.health_severe_symptoms              = health_analysis(      severe_symptoms.self_average,   severe_symptoms.diff_average,   influences.health);

% Country
results.country_get_COVID                   = country_analysis(     get_COVID.self_average,         get_COVID.diff_average,         country);
results.country_infect_others               = country_analysis(     infect_others.self_average,     infect_others.diff_average,     country);
results.country_severe_symptoms             = country_analysis(     severe_symptoms.self_average,   severe_symptoms.diff_average,   country);

[results.trust_government.p, results.trust_government.table, results.trust_government.stats]     = kruskalwallis(other.trust_government_average, country);
results.trust_government.c                  = multcompare(          results.trust_government.stats);
results.trust_government.eta_squared_H = calculate_effect_size_kruskal_wallis(results.trust_government.table{2,5}, length(results.trust_government.stats.gnames),length(other.trust_government_average));
[results.trust_science.p, results.trust_science.table, results.trust_science.stats]           = kruskalwallis(other.trust_science_average, country);
results.trust_science.c                     = multcompare(          results.trust_science.stats);
results.trust_science.eta_squared_H = calculate_effect_size_kruskal_wallis(results.trust_science.table{2,5}, length(results.trust_science.stats.gnames),length(other.trust_science_average));

results.trust_get_COVID                     = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         other.trust_government_average);
results.trust_infect_others                 = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     other.trust_government_average);
results.trust_severe_symptoms               = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   other.trust_government_average);

% Proximity to infections and deaths
 for number_known = 1:5
    for time_point = 1:3
        results.infect_direct.descript{time_point}(number_known)    = sum(influences.infect_direct{time_point}      == number_known - 1);
        results.infect_indirect.descript{time_point}(number_known)  = sum(influences.infect_indirect{time_point}    == number_known - 1);
    end
    for time_point = 2:3
        results.death.descript{time_point}(number_known)            = sum(influences.death{time_point}              == number_known - 1);
    end
 end

results.proximity_get_COVID                 =  proximity_results(   get_COVID.self_average,         get_COVID.diff_average,         influences);
results.proximity_infect_others             =  proximity_results(   infect_others.self_average,     infect_others.diff_average,     influences);
results.proximity_severe_symptoms           =  proximity_results(   severe_symptoms.self_average,   severe_symptoms.diff_average,   influences);

% General optimism bias
general_optimism = mean([influences.flu.diff_average, influences.bone.diff_average, influences.std.diff_average],2);
results.general_optimism_get_COVID          = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         general_optimism);
results.general_optimism_infect_others      = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     general_optimism);
results.general_optimism_severe_symptoms    = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   general_optimism);

% Media consumption
results.media_get_COVID                     = abs_rel_risks_corr(   get_COVID.self_average,         get_COVID.diff_average,         influences.media.self_average);
results.media_infect_others                 = abs_rel_risks_corr(   infect_others.self_average,     infect_others.diff_average,     influences.media.self_average);
results.media_severe_symptoms               = abs_rel_risks_corr(   severe_symptoms.self_average,   severe_symptoms.diff_average,   influences.media.self_average);

%% 3.3: Potential consequences of risk perception
% Physical health is skewed (columns = items, rows = % days with contacts,
% each in percentages (i.e., row1 column1: % of people who have 0 days with
% physical contacts in the context 'family'))
for i_time = 2:3
    for i_days = 1:8
        results.consequ.phys.days_contact_percent{i_time}(i_days,:) = (sum(consequ.phys.COVID{i_time} == i_days-1)/length(consequ.phys.COVID{i_time}))*100;
    end
end

% Hygiene is skewed too
results.consequ.hygiene.one_hundred         = (sum(consequ.hygiene.self{2} == 100)  / length(consequ.hygiene.self{2}))*100;
results.consequ.hygiene.ninetyfive_more     = (sum(consequ.hygiene.self{2} >= 95)   / length(consequ.hygiene.self{2}))*100;

% Compare >=95% with those <95%
results.hygiene_get_COVID_T1.self           = ttest2_Ben(           get_COVID.self{1}(:,5),        consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);
results.hygiene_get_COVID_T1.diff           = ttest2_Ben(           get_COVID.diff{1}(:,5),        consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);
results.hygiene_infect_others_T1.self       = ttest2_Ben(           infect_others.self{1}(:,7),    consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);
results.hygiene_infect_others_T1.diff       = ttest2_Ben(           infect_others.diff{1}(:,7),    consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);
results.hygiene_severe_symptoms_T1.self     = ttest2_Ben(           severe_symptoms.self{1},       consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);
results.hygiene_severe_symptoms_T1.diff     = ttest2_Ben(           severe_symptoms.diff{1},       consequ.hygiene.self{2} >= 95,   consequ.hygiene.self{2} < 95);

results.hygiene_get_COVID_T2.self           = ttest2_Ben(           get_COVID.self{2}(:,5),        consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);
results.hygiene_get_COVID_T2.diff           = ttest2_Ben(           get_COVID.diff{2}(:,5),        consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);
results.hygiene_infect_others_T2.self       = ttest2_Ben(           infect_others.self{2}(:,7),    consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);
results.hygiene_infect_others_T2.diff       = ttest2_Ben(           infect_others.diff{2}(:,7),    consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);
results.hygiene_severe_symptoms_T2.self     = ttest2_Ben(           severe_symptoms.self{2},       consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);
results.hygiene_severe_symptoms_T2.diff     = ttest2_Ben(           severe_symptoms.diff{2},       consequ.hygiene.self{3} >= 95,   consequ.hygiene.self{3} < 95);

% Mental health
results.stress.anova                        = ANOVA_2_2(            consequ.stress.self,            consequ.stress.othe,            1);
results.stress                              = stress_finances_corrs(get_COVID, infect_others, severe_symptoms, consequ.stress.self{2});
results.finances.anova                      = ANOVA_2_2(            consequ.finances.self,          consequ.finances.othe,          1);
results.finances                            = stress_finances_corrs(get_COVID, infect_others, severe_symptoms, consequ.finances.self{2});

%% Figures (either actual figures, or data transforms for R)
% Figures in main text
[fig_2,fig_3]                               = fig_2_3_transform(get_COVID, infect_others, severe_symptoms);

% Appendix C (how much did X do)
app.C.how_much_did_do                       = other.how_much_did_do.diff{3};

% Appendix D (age)
fig_age_risks(get_COVID, infect_others, severe_symptoms, demo)

% Appendix D (men/women)
app.D.gender_risk_perception_self           = [get_COVID.self_average, infect_others.self_average, severe_symptoms.self_average, demo.gender{1}];
app.D.gender_risk_perception_diff           = [get_COVID.diff_average, infect_others.diff_average, severe_symptoms.diff_average, demo.gender{1}];

% Appendix D (health)
app.D.health_risk_perception_self           = [get_COVID.self_average, infect_others.self_average, severe_symptoms.self_average, influences.health.self{3}];
app.D.health_risk_perception_diff           = [get_COVID.diff_average, infect_others.diff_average, severe_symptoms.diff_average, influences.health.self{3}];

% Appendix E (country)
app.E.country_risk_perception_self          = [get_COVID.self_average, infect_others.self_average, severe_symptoms.self_average, country];
app.E.country_risk_perception_diff          = [get_COVID.diff_average, infect_others.diff_average, severe_symptoms.diff_average, country];

% Appendix H (general optimism)
fig_general_optimism_risks(get_COVID, infect_others, severe_symptoms, general_optimism)

% Appendix I (Physical contacts; Pre-COVID, During-COVID)
histogram_physical_contacts(consequ.phys.normal,    'Before COVID')
histogram_physical_contacts(consequ.phys.COVID,     'During COVID')

% Figure for Apendix J
histogram_health(consequ)

% Appendix X (trust in government/science)
app.trust.government                        = [other.trust_government{1}, country, ones(length(country),1); other.trust_government{2}, country, ones(length(country),1)+1; other.trust_government{3}, country, ones(length(country),1)+2];
app.trust.science                           = [other.trust_science{1}, country, ones(length(country),1); other.trust_science{2}, country, ones(length(country),1)+1; other.trust_science{3}, country, ones(length(country),1)+2];

