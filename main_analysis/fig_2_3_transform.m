function [e,j] = fig_2_3_transform(get_COVID, infect_others, severe_symptoms)
% This is just a script to get the data in the correct format for using
% them in R

a = [get_COVID.self{1}(:,5); get_COVID.self{2}(:,5); get_COVID.self{3}(:,5)];
b = [infect_others.self{1}(:,7); infect_others.self{2}(:,7); infect_others.self{3}(:,7)];
c = [severe_symptoms.self{1}; severe_symptoms.self{2}; severe_symptoms.self{3}];
d = [ones(length(get_COVID.self{1}(:,5)),1); ones(length(get_COVID.self{1}(:,5)),1)+1; ones(length(get_COVID.self{1}(:,5)),1)+2]; 
e = [a, b, c, d];

f = [get_COVID.diff{1}(:,5); get_COVID.diff{2}(:,5); get_COVID.diff{3}(:,5)];
g = [infect_others.diff{1}(:,7); infect_others.diff{2}(:,7); infect_others.diff{3}(:,7)];
h = [severe_symptoms.diff{1}; severe_symptoms.diff{2}; severe_symptoms.diff{3}];
j = [f, g, h, d];

end
