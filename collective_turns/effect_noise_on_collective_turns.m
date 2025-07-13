%%
% This MATLAB code generates multiple contour plots to visualize the response accuracy of different algorithms or metrics under varying levels of noise. 
% Specifically, it produces three sets of plots, each displaying the response accuracy for different metrics (PNIN, WSIN, and FCIN) under different noise levels and initial conditions.
clear;clc;
load("../data/collective_turns_data/noise_effect_acc_resp.mat") % load all necessary data for reproduing results in simualation experiments of collective turns
addpath("../utility/")
noise_level_list = [0:0.5:10];
draw_level_list = noise_level_list; %[0, 2, 4, 6, 8, 10];
indices = arrayfun(@(x) find(noise_level_list == x, 1), draw_level_list, 'UniformOutput', false);
indices = cellfun(@(x) ifelse(isempty(x), NaN, x), indices);
% load("cmoceandeep.mat")
figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_acc_NMS,"ShowText",true); % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap(flip(autumn(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-PNIN")
ax.FontSize=15;
set(gca, 'Fontname', 'helvetica', 'FontSize', 20)

figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_acc_AMS,"ShowText",true);  % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap(flip(autumn(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-WSIN")
ax.FontSize=15;

set(gca, 'Fontname', 'helvetica', 'FontSize', 20)
figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_acc_Ave,"ShowText",true);  % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap(flip(autumn(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-FCIN")
ax.FontSize=15;
set(gca, 'Fontname', 'helvetica', 'FontSize', 20)
%%
noise_level_list = [0:0.5:10];
draw_level_list = noise_level_list; %[0, 2, 4, 6, 8, 10];
indices = arrayfun(@(x) find(noise_level_list == x, 1), draw_level_list, 'UniformOutput', false);
indices = cellfun(@(x) ifelse(isempty(x), NaN, x), indices);
load("cmoceandeep.mat")
figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_r_area_NMS,"ShowText",true);  % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap((winter(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-PNIN")
ax.FontSize=15;
set(gca, 'Fontname', 'helvetica', 'FontSize', 20)

figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_r_area_AMS,"ShowText",true);  % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap((winter(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-WSIN")
ax.FontSize=15;
set(gca, 'Fontname', 'helvetica', 'FontSize', 20)

figure()
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
[C,cf] = contourf(mean_r_area_Ave,"ShowText",true);  % draw the contourf in matlab
clabel(C,cf,'FontSize',20, 'FontWeight','bold','LabelSpacing',100)
% cf.LineWidth = 1;
colormap((winter(255)))
colorbar
ax=gca;
ax.YTickLabel = {'10','12','14','16','18','20'};
ax.XTick = [1,5,10,15,20];
ax.XTickLabel = cellstr(string([0,3,5,7,10])); %cellstr(string(draw_level_list));
% caxis([0.2,1])
% xtickangle(90)
title("response accuracy-FCIN")
ax.FontSize=15;
set(gca, 'Fontname', 'helvetica', 'FontSize', 20)
