function [H2] = ANOVA_person_time(self,othe,column)
%% Format the data to be useable for anovan
self_T1  = self{1}(:,column)';
othe_T1  = othe{1}(:,column)';
self_T2  = self{2}(:,column)';
othe_T2  = othe{2}(:,column)';
self_T3  = self{3}(:,column)';
othe_T3  = othe{3}(:,column)';
X = [self_T1 self_T2 self_T3 othe_T1 othe_T2 othe_T3]';

nsubj = length(self_T1);
nlevelsPerson = 2;
nlevelsTime = 3;

Subj = repmat(1:nsubj, 1, nlevelsPerson*nlevelsTime);

personSelf = repmat({'self'}, 1, nlevelsTime*nsubj);
personOthe = repmat({'othe'}, 1, nlevelsTime*nsubj);
Person = [personSelf'; personOthe'];

timeT1 = repmat ({'T1'}, nsubj, 1);
timeT2 = repmat ({'T2'}, nsubj, 1);
timeT3 = repmat ({'T3'}, nsubj, 1);
Time = [timeT1' timeT2' timeT3' timeT1' timeT2' timeT3']';

%% Run the actual ANOVA
[H2.p, H2.table, H2.stats, H2.terms] = anovan(X, {Person Time Subj}, 'random', 3, 'model', 2, 'varnames', {'Person' 'Time' 'Subj'});
%H2.multcomp = multcompare(H2.stats, 'dimension', [1 2]);

end
