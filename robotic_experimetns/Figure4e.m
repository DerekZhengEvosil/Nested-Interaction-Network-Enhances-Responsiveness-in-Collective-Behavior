clear;clc;
addpath("../utility/")
load("../data/robotic_experiments_data/collective_hovering_curvature.mat")
figure
figSize_L = 3.5;
figSize_W = 6;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
vs = violinplot(violin_data, violin_label, 'ShowMean', true, 'ShowMedian', false,'MarkerSize', 10);
ylabel("mean curvature")
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)