function [get_COVID, infect_others, severe_symptoms, place, influences, consequ, other, demo, country] = create_variables(data)
%% Risk perception
get_COVID               = format_vars_4_horizons(data, 8:11, 12:15, 1);
infect_others           = format_vars_6_contexts(data, 44:49, 50:55, 1);
severe_symptoms         = format_vars_self_othe_diff(data, 37, 39, 1);

%% Potental influences
influences.flu          = format_vars_4_horizons(data, 72:75, 76:79, 1);
influences.std          = format_vars_4_horizons(data, 56:59, 64:67, 1);
influences.bone         = format_vars_4_horizons(data, 60:63, 68:71, 1);
influences.health       = format_vars_self_othe_diff(data, 102, 103, 1);

%% Potential consequences
consequ.suffering_future= format_vars_6_contexts(data, 140:145, 146:151, 1);
consequ.suffering_past  = format_vars_6_contexts(data, 202:207, 208:213, 2);
consequ.usual_pleasure  = format_vars_6_contexts(data, 152:157, 158:163, 1);
consequ.stress          = format_vars_self_othe_diff(data, 164, 165, 2);
consequ.finances        = format_vars_self_othe_diff(data, 166, 167, 2);

%% All variables that don't fit into the scheme above
for i_time_point = 1:3
    % Known people who got infected with COVID    
    influences.infect_direct{i_time_point}  = data{i_time_point}(:,100) - 1;
    influences.infect_indirect{i_time_point}= data{i_time_point}(:,101) - 1;
    % Media consumption
    influences.media.self{i_time_point}     = data{i_time_point}(:,22) - 1;
    % Hygiene (diff is coded reveresed because this is a positive item)
    consequ.hygiene.self{i_time_point}      = data{i_time_point}(:,16) - 1;
    consequ.hygiene.othe{i_time_point}      = data{i_time_point}(:,17) - 1;
    consequ.hygiene.diff{i_time_point}      = consequ.hygiene.self{i_time_point} - consequ.hygiene.othe{i_time_point};
    % Trust in government and science
    other.trust_government{i_time_point}    = data{i_time_point}(:,26) - 1;
    other.trust_science{i_time_point}       = data{i_time_point}(:,28) - 1;  
end

for i_time_point = 2:3
    influences.death{i_time_point}          = data{i_time_point}(:,234) - 1;
    % N of days with physical contacts per week
    consequ.phys.normal{i_time_point}       = data{i_time_point}(:,214:214+5) - 1;
    consequ.phys.normal{i_time_point}(:,7)  = mean(consequ.phys.normal{i_time_point}, 2);
    consequ.phys.COVID{i_time_point}        = data{i_time_point}(:,220:220+5) - 1;
    consequ.phys.COVID{i_time_point}(:,7)   = mean(consequ.phys.COVID{i_time_point}, 2);
    consequ.phys.diff{i_time_point}         = consequ.phys.normal{i_time_point} - consequ.phys.COVID{i_time_point};
    % If infected: how much did people do?
    other.how_much_did_do.self{i_time_point}= data{i_time_point}(:,168:172) - 1;
    other.how_much_did_do.othe{i_time_point}= data{i_time_point}(:,173:177) - 1;
    other.how_much_did_do.diff{i_time_point}= other.how_much_did_do.self{i_time_point} - other.how_much_did_do.othe{i_time_point};
    % Living situation
    other.living_situation{i_time_point}    = data{i_time_point}(:,227:232) - 1;
end

%% Countries: 1 = DE; 2 = UK; 3 = US
TO = true(length(data{3}),1); DE = data{3}(:,size(data{3}, 2)) == 1;
UK = data{3}(:,size(data{3}, 2)) == 2; US = data{3}(:,size(data{3}, 2)) == 3;
place = {TO, UK, US, DE}; % This order of countries is now different from initial order, but matches the paper's appendix

%% Calculate averages across all 3 time points
severe_symptoms.self_average    = average_across_time(severe_symptoms.self, 1);
severe_symptoms.othe_average    = average_across_time(severe_symptoms.othe, 1);
severe_symptoms.diff_average    = average_across_time(severe_symptoms.diff, 1);
influences.media.self_average   = average_across_time(influences.media.self, 1);
other.trust_government_average  = average_across_time(other.trust_government, 1);
other.trust_science_average     = average_across_time(other.trust_science, 1);

% Calculate aveage across each subitem and reformat for later analyses
for i_time_horizon = 1:4
    get_COVID.diff_time_horizon_averages{i_time_horizon} = mean([get_COVID.diff{1}(:,i_time_horizon), get_COVID.diff{2}(:,i_time_horizon), get_COVID.diff{3}(:,i_time_horizon)], 2);
end
get_COVID.diff_time_horizon_averages_mat    = cell2mat(             get_COVID.diff_time_horizon_averages);

for i_social_context = 1:6
    infect_others.diff_social_context_averages{i_social_context} = mean([infect_others.diff{1}(:,i_social_context), infect_others.diff{2}(:,i_social_context), infect_others.diff{3}(:,i_social_context)], 2);
end
infect_others.diff_social_context_averages_mat = cell2mat(infect_others.diff_social_context_averages);


%% Demographics
for i_pla = 1:4
    demo.n_total{i_pla}                = size(data{3}(place{i_pla},:),1);
    demo.age{i_pla}                    = data{3}(place{i_pla},3);
    demo.age_mean{i_pla}               = mean(data{3}(place{i_pla},3));
    demo.age_sd{i_pla}                 = std(data{3}(place{i_pla},3));
    demo.age_min{i_pla}                = min(data{3}(place{i_pla},3));
    demo.age_max{i_pla}                = max(data{3}(place{i_pla},3));
    demo.gender_percent_female{i_pla}  = (sum(data{3}(place{i_pla},4) - 1 == 0)/demo.n_total{i_pla})*100;
    demo.gender_percent_male{i_pla}    = (sum(data{3}(place{i_pla},4) - 1 == 1)/demo.n_total{i_pla})*100;
    demo.gender_percent_other{i_pla}   = (sum(data{3}(place{i_pla},4) - 1 == 2)/demo.n_total{i_pla})*100; 
    demo.gender{i_pla}                 = data{3}(place{i_pla},4) - 1;
end

country = data{3}(:,size(data{3}, 2));
end
