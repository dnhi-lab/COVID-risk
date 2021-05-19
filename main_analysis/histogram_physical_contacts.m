function histogram_physical_contacts(physical_contacts, title_name)

histo_labels = {'Family'; 'Friends'; 'Colleagues'; 'Recreation'; 'Travel'; 'Public chores'};
xlabeltext = {'', '', '', '', 'Days per week with physical contacts', 'Days per week with physical contacts'};

figure
for i_sub_plot = 1:6
subplot(3,2,i_sub_plot)
histogram(physical_contacts{2}(:,i_sub_plot), [-0.5:7.5])
ylim([0 length(physical_contacts{2}(:,i_sub_plot))])
yticks(0:length(physical_contacts{2}(:,i_sub_plot))/5:length(physical_contacts{2}(:,i_sub_plot)))
yticklabels({'0%', '20%', '40%', '60%', '80%', '100%'})
xlabel(xlabeltext(i_sub_plot))
title(histo_labels(i_sub_plot))
end
sgtitle(title_name)

end
