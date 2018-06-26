load('TvI_1258BF6C7E_INTERVENTION_2_IM1_0_25_TUpblock.mat')
number = createMatrix(summaryOne,summaryTwo,summaryThree);
average = mean(number);
subplot(1,3,1);
for i = 1:size(number,1)
    plot(number(i,:),'--r')
    hold on
end
plot(average,'r','LineWidth',3)
title('2 IM1inflRate | 0.25 TUpblock');
xlabel('Time [days]')
ylabel('Tumor [cells]')
ylim([0 6e4])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values
vline(8,'k--','1');
vline(24,'k--','2');
vline(32,'k--','3');
hold off

load('TvI_72C576B98_INTERVENTION_2_IM1_0_50_TUpblock.mat')
number = createMatrix(summaryOne,summaryTwo,summaryThree);
average = mean(number);
subplot(1,3,2);
for i = 1:size(number,1)
    plot(number(i,:),'--g')
    hold on
end
title('2 IM1inflRate | 0.50 TUpblock');
plot(average,'g','LineWidth',3)
xlabel('Time [days]')
ylabel('Tumor [cells]')
ylim([0 6e4])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values
vline(8,'k--','1');
vline(24,'k--','2');
vline(32,'k--','3');
hold off

load('TvI_9B334EF46_INTERVENTION_2_IM1_0_75_TUpblock.mat')
number = createMatrix(summaryOne,summaryTwo,summaryThree);
average = mean(number);
subplot(1,3,3);
for i = 1:size(number,1)
    plot(number(i,:),'--b')
    hold on
end
plot(average,'b','LineWidth',3)
title('2 IM1inflRate | 0.75 TUpblock');
xlabel('Time [days]')
ylabel('Tumor [cells]')
ylim([0 6e4])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values
vline(8,'k--','1');
vline(24,'k--','2');
vline(32,'k--','3');
hold off