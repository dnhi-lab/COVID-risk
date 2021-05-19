function results = results_mean_risks(data,column)

for i_time = 1:3
    results{i_time} = mean(data{i_time}(:,column));
end

end
