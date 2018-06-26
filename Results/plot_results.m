load('TvI_459E3AB2F_INTERVENTION_7_IM1_IM2_0_75_TUpblock.mat')
number = createMatrix(summaryOne,summaryTwo,summaryThree);
average = mean(number);
subplot(1,2,1);
for i = 1:size(number,1)
    plot(number(i,:),'--r')
    hold on
end
plot(average,'r','LineWidth',3)
title('7 IM1 | 7 IM2 | 0.75 TUpblock');
xlabel('Time')
ylabel('Tumor cells')
ylim([0 7E4])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values
vline(8,'k--','1');
vline(24,'k--','2');
vline(32,'k--','3');
hold off

load('TvI_5A0F64CA1_INTERVENTION_7_IM1_0_75_TUpblock.mat')
number = createMatrix(summaryOne,summaryTwo,summaryThree);
average = mean(number);
subplot(1,2,2);
for i = 1:size(number,1)
    plot(number(i,:),'--g')
    hold on
end
title('7 IM1 | 0.75 TUpblock');
plot(average,'g','LineWidth',3)
xlabel('Time')
ylabel('Tumor cells')
ylim([0 7E4])
xt = get(gca, 'XTick');                                 % 'XTick' Values
set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values

vline(8,'k--','1');
vline(24,'k--','2');
vline(32,'k--','3');
hold off
% 
% load('TvI_9B334EF46_INTERVENTION_2_IM1_0_75_TUpblock.mat')
% number = createMatrix(summaryOne,summaryTwo,summaryThree);
% average = mean(number);
% subplot(1,3,3);
% for i = 1:size(number,1)
%     plot(number(i,:),'--y')
%     hold on
% end
% plot(average,'y','LineWidth',3)
% title('2 IM1 | 0.75 TUpblock');
% xlabel('Time')
% ylabel('Tumor cells')
% ylim([0 7E4])
% xt = get(gca, 'XTick');                                 % 'XTick' Values
% set(gca, 'XTick', xt, 'XTickLabel', xt*7.5)             % Relabel 'XTick' With 'XTickLabel' Values
% hold off