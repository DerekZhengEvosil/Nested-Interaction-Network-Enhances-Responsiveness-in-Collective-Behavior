% This MATLAB code generates a violin plot to visualize the distribution of the average heading error in the collective following task. 
% The plot will show how the heading error varies across different categories, with the mean value represented as a marker in the plot.
clear;clc;
addpath("../utility/")
load("../data/robotic_experiments_data/collective_following_heading_error.mat")
figure
figSize_L = 4;
figSize_W = 5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
vs = violinplot(violin_data, violin_label, 'ShowMean', true, 'ShowMedian', false,'MarkerSize', 6);
ylabel("average heading error")
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
