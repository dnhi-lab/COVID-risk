function var = format_vars_self_othe_diff(data, self_columns, othe_columns, minimum_time)

for i_time_point = minimum_time:3
    var.self{i_time_point}      = data{i_time_point}(:,self_columns) - 1;
    var.othe{i_time_point}      = data{i_time_point}(:,othe_columns) - 1;
    var.diff{i_time_point}      = var.othe{i_time_point} - var.self{i_time_point};
end

end
