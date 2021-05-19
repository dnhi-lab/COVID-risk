function fig_age_risks(get_COVID, infect_others, severe_symptoms, demo)

plooots = [...
    get_COVID.self_average, infect_others.self_average, severe_symptoms.self_average, ...    
    get_COVID.diff_average, infect_others.diff_average, severe_symptoms.diff_average];
titletext = {'Get COVID', 'Infect Others', 'Severe Symptoms', '', '', ''};
ylimits = [0 100; 0 100; 0 100; -80 60; -80 60; -80 60];
ylabeltext = {'Absolute risk perception', '', '', 'Relative risk perception', '', ''};
xlabeltext = {'', '', '', 'Age', 'Age', 'Age'};

figure
for i_plot = 1:6
    subplot(2,3,i_plot)
    scatter(demo.age{1}, plooots(:,i_plot))
    xlim([15 85])
    xlabel(xlabeltext(i_plot))
    ylim(ylimits(i_plot,:))
    yticks(-100:20:100)
    ylabel(ylabeltext(i_plot))
    line = lsline();
    line.Color = 'r';
    line.LineWidth = 5;
    t = title(titletext(i_plot));
    t.FontAngle = 'italic';
end

end
