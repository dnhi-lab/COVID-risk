function fig_general_optimism_risks(get_COVID, infect_others, severe_symptoms, general_optimism)

plooots = [...
    get_COVID.self_average, infect_others.self_average, severe_symptoms.self_average, ...    
    get_COVID.diff_average, infect_others.diff_average, severe_symptoms.diff_average];
titletext = {'Get COVID', 'Infect Others', 'Severe Symptoms', '', '', ''};
ylimits = [0 100; 0 100; 0 100; -80 80; -80 80; -80 80];
ylabeltext = {'Absolute risk perception', '', '', 'Relative risk perception', '', ''};
xlabeltext = {'', '', '', 'General optimism', 'General optimism', 'General optimism'};

figure
for i_plot = 1:6
    subplot(2,3,i_plot)
    scatter(general_optimism, plooots(:,i_plot))
    xlim([-50 50])
    xlabel(xlabeltext(i_plot))
    ylim([ylimits(i_plot,:)])
    yticks([-100:20:100])
    xticks([-100:20:100])
    ylabel(ylabeltext(i_plot))
    line = lsline();
    line.Color = 'r';
    line.LineWidth = 5;
    t = title(titletext(i_plot));
    t.FontAngle = 'italic';
end

end
