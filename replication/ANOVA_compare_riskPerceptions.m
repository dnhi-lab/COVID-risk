function [results] = ANOVA_compare_riskPerceptions(var1, var2, var3)

nSubj = length(var1);
nCond = 3;

s = repmat(1:nSubj, nCond, 1);
q = repmat(1:nCond, nSubj,1);
X = [var1, var2, var3]';
X = reshape(X, nSubj*nCond, 1);
Subj= reshape(s, nSubj*nCond, 1);
Question = reshape(q', nSubj*nCond, 1);

[results.p, results.table, results.stats] = anovan(X, {Question Subj}, 'random', 2);
[results.posthoc.c, results.posthoc.m] = multcompare(results.stats);

end
