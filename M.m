%% M
load('data/points.mat')

%% question 1
scatter(l(1,:),l(2,:),'x');
%% question 2
xlim([0 5]);
ylim([-1 1]);
%% question 3
xlabel('time');
ylabel('sales');
%% question 4
errorbar(l(1,:),l(2,:),err,'LineStyle','none','Marker','*');
xlabel('time');
ylabel('sales');
