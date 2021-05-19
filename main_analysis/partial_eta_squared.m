function p_eta_squ = partial_eta_squared(variable, error)
% Formula taken from https://www.statisticshowto.com/eta-squared/

p_eta_squ = variable/(variable+error);

end
