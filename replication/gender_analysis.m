function results = gender_analysis(self_average, diff_average, gender)

results.self               = ttest2_Ben(self_average, gender == 0, gender == 1);
results.self.male_mean     = mean(self_average(gender == 1));
results.self.male_sd       = std(self_average(gender == 1));
results.self.female_mean   = mean(self_average(gender == 0));
results.self.female_sd     = std(self_average(gender == 0));
results.diff               = ttest2_Ben(diff_average, gender == 0, gender == 1);

end
