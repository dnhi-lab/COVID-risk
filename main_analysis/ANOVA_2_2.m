function r = ANOVA_2_2(self, othe, column)
%% Format the data to be useable for anovan
self_T2  = self{2}(:,column)';
othe_T2  = othe{2}(:,column)';
self_T3  = self{3}(:,column)';
othe_T3  = othe{3}(:,column)';
X = [self_T2 self_T3 othe_T2 othe_T3]';

nsubj = length(self_T2);
nlevelsPerson = 2;
nlevelsTime = 2;

Subj = repmat(1:nsubj, 1, nlevelsPerson*nlevelsTime);

personSelf = repmat({'self'}, 1, nlevelsTime*nsubj);
personOthe = repmat({'othe'}, 1, nlevelsTime*nsubj);
Person = [personSelf'; personOthe'];

timeT2 = repmat ({'T2'}, nsubj, 1);
timeT3 = repmat ({'T3'}, nsubj, 1);
Time = [timeT2' timeT3' timeT2' timeT3']';

%% Run the actual ANOVA
[r.p, r.table, r.stats, r.terms] = anovan(X, {Person Time Subj}, 'random', 3, 'model', 2, 'varnames', {'Person' 'Time' 'Subj'});
r.SS_person              = r.table{2,2};
r.SS_time                = r.table{3,2};
r.SS_person_time         = r.table{5,2};
r.SS_error               = r.table{8,2};
r.p_eta_squ_person       = partial_eta_squared(r.SS_person,       r.SS_error);
r.p_eta_squ_time         = partial_eta_squared(r.SS_time,         r.SS_error);
r.p_eta_squ_person_time  = partial_eta_squared(r.SS_person_time,  r.SS_error);

r.self_mean_T2 = mean(self{2});
r.self_mean_T3 = mean(self{3});

end
