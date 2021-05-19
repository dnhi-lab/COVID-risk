function var = format_vars_4_horizons(data,self_columns, othe_columns, minimum_time)

for i_time_point = minimum_time:3
    var.self{i_time_point}            = data{i_time_point}(:,self_columns) - 1; % -1 because SoSciSurvey goes from 1-101, not 0-100
    var.self{i_time_point}(:,5)       = mean(var.self{i_time_point}, 2);
    var.othe{i_time_point}            = data{i_time_point}(:,othe_columns) - 1;
    var.othe{i_time_point}(:,5)       = mean(var.othe{i_time_point}, 2);
    var.diff{i_time_point}            = var.othe{i_time_point} - var.self{i_time_point};
end

if minimum_time == 1
    var.self_average      = average_across_time(var.self, 5);
    var.othe_average      = average_across_time(var.othe, 5);
    var.diff_average      = average_across_time(var.diff, 5);
end

end
