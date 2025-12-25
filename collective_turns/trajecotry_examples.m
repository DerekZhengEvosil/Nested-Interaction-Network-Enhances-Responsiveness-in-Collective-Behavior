%% 
% This MATLAB code generates two figures (3g and 3h) that visualize the group response signals 
% for different categories of collective behavior models (PNIN, WSIN, FCIN) under varying conditions, such as noise level and time. 
% These figures help analyze how the collective response varies across models, and how these responses are compared to a standard signal.
% group response signals of PNIN
%% Figure 3g
clear;clc
addpath("../utility/")
folder_name = "../data/collective_turns_data/PNIN_eta_10/Sim_1";
gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%%
folder_name = "../data/collective_turns_data/WSIN_eta_10/Sim_1";
gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%%
folder_name = "../data/collective_turns_data/FCIN_eta_10/Sim_1";
gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%% Figure 3h
clear;clc
addpath("../utility/")
% theta_info = 75
load("../data/collective_turns_data/Fig2h_data.mat")
colorlist_1 = [254,229,217
252,174,145
251,106,74
203,24,29]./255;
colorlist_2 = [239,243,255
189,215,231
107,174,214
33,113,181]./255;
figure
figSize_L = 48;
figSize_W = 5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
plot(time_cell, mean_cos_heading_AMS_tmp_cell, 'LineWidth',1,'Color',colorlist_1(end,:))
hold on
plot(time_cell, mean_cos_heading_NMS_tmp_cell, 'LineWidth',1,'Color',colorlist_2(end,:))
hold on
plot(time_cell, mean_cos_heading_Ave_tmp_cell, 'LineWidth',1,'Color',[127, 127, 127]./255)
hold on
plot(time_cell, stand_cos_heading_cell, '-k', 'LineWidth',0.5)
xlim([0, 100])
%         ylim([0, 1])
xlabel("time [s]")
ylabel("$cos(\theta(t))$", 'Interpreter','latex')
legend(["WSIN", "PNIN", "FCIN", "standard signal"],'Location','bestoutside','Box','off')
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
