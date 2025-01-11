clear;clc;
load("../data/robotic_experiments_data/collective_following_heading_error.mat")
figure
figSize_L = 4;
figSize_W = 5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
vs = violinplot(violin_data, violin_label, 'ShowMean', true, 'ShowMedian', false,'MarkerSize', 6);
ylabel("average heading error")
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)