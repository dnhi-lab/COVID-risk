function r = ANOVA_3_2_mixed(self, othe, column)

%% Format the data to be useable for anovan
self_T1  = self{1}(:,column);
othe_T1  = othe{1}(:,column);
self_T2  = self{2}(:,column);
othe_T2  = othe{2}(:,column);
self_T3  = self{3}(:,column);
othe_T3  = othe{3}(:,column);
X = [self_T1; self_T2; self_T3; othe_T1; othe_T2; othe_T3];
%X = [self_T1 self_T2 self_T3 othe_T1 othe_T2 othe_T3]';

personSelf = repmat({'self'}, 1, length(X)/2);
personOthe = repmat({'othe'}, 1, length(X)/2);
person = [personSelf'; personOthe'];

timeT1 = repmat ({'T1'}, length(self_T1), 1);
timeT2 = repmat ({'T2'}, length(self_T2), 1);
timeT3 = repmat ({'T3'}, length(self_T3), 1);
time = [timeT1; timeT2; timeT3; timeT1; timeT2; timeT3];

%{
t1 = ones(length(self_T1), 1);
t2 = ones(length(self_T2), 1)+1;
t3 = ones(length(self_T3), 1)+2;
ts = [t1;t2;t3];
time = [ts;ts];
%}

%nsubj = length(self_T1);
nlevelsPerson = 2;
%nlevelsTime = 3;
subj = repmat(1:length(X)/2, 1, nlevelsPerson);

nesting = [0 0 0; 0 0 0; 0 1 0];

%% Run the actual ANOVA
[r.p, r.table, r.stats, r.terms] = anovan(X, {person time subj}, 'random', 3, 'model', [1 0 0; 0 1 0; 0 0 1; 1 1 0], 'nested', nesting, 'varnames', {'Person' 'Time' 'Subj'});

r.SS_person              = r.table{2,2};
r.SS_time                = r.table{3,2};
r.SS_person_time         = r.table{5,2};
r.SS_error               = r.table{6,2};
r.p_eta_squ_person       = partial_eta_squared(r.SS_person,       r.SS_error);
r.p_eta_squ_time         = partial_eta_squared(r.SS_time,         r.SS_error);
r.p_eta_squ_person_time  = partial_eta_squared(r.SS_person_time,  r.SS_error);



end
