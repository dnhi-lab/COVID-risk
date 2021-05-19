function p_eta_squ = partial_eta_squared(SS_effect, SS_error)

p_eta_squ = SS_effect/(SS_effect+SS_error);

end
