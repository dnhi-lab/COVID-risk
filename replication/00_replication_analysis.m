%% COVID replication
% This is a script for the replication of our COVID study

clear
cd('')
load('data_between_v7.mat')

%% Create the variables
[get_COVID, infect_others, severe_symptoms, place, influences, consequ, other, demo, country, dem] = replication_create_variables(data_bet);

age     = [demo.age{1}; demo.age{2}; demo.age{3}];
gender  = [demo.gender{1}; demo.gender{2}; demo.gender{3}];
health  = [influences.health.self{1}; influences.health.self{2}; influences.health.self{3}];

get_C = append_Ts_self_othe(get_COVID);
inf_O = append_Ts_self_othe(infect_others);
sev_S = append_Ts_self_othe(severe_symptoms);

flu = append_Ts_self_othe(influences.flu);
std = append_Ts_self_othe(influences.std);
bon = append_Ts_self_othe(influences.bone);

%% Optimism bias for Get COVID, Infect Others, and Severe Symptoms
results.get_COVID = ANOVA_3_2_mixed(get_COVID.self, get_COVID.othe, 5);
results.inf_other = ANOVA_3_2_mixed(infect_others.self, infect_others.othe, 7);
results.sev_sympt = ANOVA_3_2_mixed(severe_symptoms.self, severe_symptoms.othe, 1);

%% More control over outcomes seems to lead to more optimism
% Comparing optimism biases
% One-way repeated-designs ANOVA to compare whether there are differences between the 3
% biases, and post-hoc comparisons to test which is different from which
results.compare_COVID_risks = compare_risks(get_C.diff(:,5), inf_O.diff(:,7), sev_S.diff(:,1));

% One-way ANOVA to compare control optimism bias questions
results.compare_control_risks = compare_risks(flu.diff(:,5), std.diff(:,5), bon.diff(:,5));

% Optimism bias and time horizon for Get COVID
[results.get_COVID.optimism_time_horizon.p, results.get_COVID.optimism_time_horizon.table, results.get_COVID.optimism_time_horizon.stats] = anova1(get_C.diff(:,1:4));
results.get_COVID.optimism_time_horizon.c   = multcompare(          results.get_COVID.optimism_time_horizon.stats);
results.get_COVID.optimism_time_horizon.p_eta_squ = partial_eta_squared(results.get_COVID.optimism_time_horizon.table{2,2}, results.get_COVID.optimism_time_horizon.table{3,2});

% Optimism bias and social context for Infect Others
[results.infect_others.optimism_social_context.p, results.infect_others.optimism_social_context.table, results.infect_others.optimism_social_context.stats] = anova1(inf_O.diff(:,1:6));
results.infect_others.optimism_social_context.c = multcompare(results.infect_others.optimism_social_context.stats);
results.infect_others.optimism_social_context.p_eta_squ = partial_eta_squared(results.infect_others.optimism_social_context.table{2,2}, results.infect_others.optimism_social_context.table{3,2});

% How much did different people do to prevent infection?
[results.other.how_much_did_do.p, results.other.how_much_did_do.table, results.other.how_much_did_do.stats] = anova1(other.how_much_did_do.diff{3});
results.other.how_much_did_do.c             = multcompare(results.other.how_much_did_do.stats);
results.other.how_much_did_do.p_eta_squ = partial_eta_squared(results.other.how_much_did_do.table{2,2}, results.other.how_much_did_do.table{3,2});

%% People largely aware of risks
% Age
results.age_get_COVID           = abs_rel_risks_corr(get_C.self(:,5), get_C.diff(:,5), age);
results.age_infect_others       = abs_rel_risks_corr(inf_O.self(:,7), inf_O.diff(:,7), age);
results.age_severe_symptoms     = abs_rel_risks_corr(sev_S.self(:,1), sev_S.diff(:,1), age);

% Gender
results.gender_get_COVID       = gender_analysis(get_C.self(:,5), get_C.diff(:,5), gender);
results.gender_infect_others   = gender_analysis(inf_O.self(:,7), inf_O.diff(:,7), gender);
results.gender_severe_symptoms = gender_analysis(sev_S.self(:,1), sev_S.diff(:,1), gender);

% Overall health
results.health_get_COVID        = health_analysis(get_C.self(:,5), get_C.diff(:,5), health);
results.health_infect_others    = health_analysis(inf_O.self(:,7), inf_O.diff(:,7), health);
results.health_severe_symptoms  = health_analysis(sev_S.self(:,1), sev_S.diff(:,1), health);

%% Ceiling effects
% Physical health is skewed (columns = items, rows = % days with contacts,
% each in percentages (i.e., row1 column1: % of people who have 0 days with
% physical contacts in the context 'family'))
for i_time = 2:3
    for i_days = 1:8
        results.consequ.phys.days_contact_percent{i_time}(i_days,:) = (sum(consequ.phys.COVID{i_time} == i_days-1)/length(consequ.phys.COVID{i_time}))*100;
    end
end

% Hygiene is skewed too
t = 3;
rep.consequ.hygiene.one_hundred         = (sum(consequ.hygiene.self{t} == 100)  / length(consequ.hygiene.self{t}))*100;
rep.consequ.hygiene.ninetyfive_more     = (sum(consequ.hygiene.self{t} >= 95)   / length(consequ.hygiene.self{t}))*100;
