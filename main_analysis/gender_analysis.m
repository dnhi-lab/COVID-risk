function results = gender_analysis(self_average, diff_average, demo)

results.self               = ttest2_Ben(self_average, demo.gender{1} == 0, demo.gender{1} == 1);
results.self.male_mean     = mean(self_average(demo.gender{1} == 1));
results.self.male_sd       = std(self_average(demo.gender{1} == 1));
results.self.female_mean   = mean(self_average(demo.gender{1} == 0));
results.self.female_sd     = std(self_average(demo.gender{1} == 0));
results.diff               = ttest2_Ben(diff_average, demo.gender{1} == 0, demo.gender{1} == 1);

end
