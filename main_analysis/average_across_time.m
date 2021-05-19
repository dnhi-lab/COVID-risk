function out = average_across_time(var, column)

out = mean([var{1}(:,column), var{2}(:,column), var{3}(:,column)], 2);

end
