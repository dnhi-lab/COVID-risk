function histogram_health(consequ)

figure
subplot(1,3,1)
histogram(consequ.hygiene.self{1}, [0.5:1:100.5])
ylim([0 length(consequ.hygiene.self{1})/2])
yticks(0:length(consequ.hygiene.self{1})/5:length(consequ.hygiene.self{1}))
yticklabels({'0%', '20%', '40%', '60%', '80%', '100%'})
xlabel('Hygiene')
title('T1')
subplot(1,3,2)
histogram(consequ.hygiene.self{2}, [0.5:1:100.5])
ylim([0 length(consequ.hygiene.self{1})/2])
yticks(0:length(consequ.hygiene.self{1})/5:length(consequ.hygiene.self{1}))
yticklabels({'0%', '20%', '40%', '60%', '80%', '100%'})
xlabel('Hygiene')
title('T2')
subplot(1,3,3)
histogram(consequ.hygiene.self{3}, [0.5:1:100.5])
ylim([0 length(consequ.hygiene.self{1})/2])
yticks(0:length(consequ.hygiene.self{1})/5:length(consequ.hygiene.self{1}))
yticklabels({'0%', '20%', '40%', '60%', '80%', '100%'})
xlabel('Hygiene')
title('T3')

end
