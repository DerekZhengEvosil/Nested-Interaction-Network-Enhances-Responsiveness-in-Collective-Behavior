%% Figure 3g
clear;clc
addpath("../utility/")
folder_name = "../data/collective_turns_data/PNIN_eta_10/Sim_1";
[mean_acc, r_area, r_acc, cos_heading] = gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%%
folder_name = "../data/collective_turns_data/WSIN_eta_10/Sim_1";
[mean_acc, r_area, r_acc, cos_heading] = gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%%
folder_name = "../data/collective_turns_data/FCIN_eta_10/Sim_1";
[mean_acc, r_area, r_acc, cos_heading] = gen_acc_r_freq_patch(folder_name, 0, 1, " ", 1, 100, 2, -1.8);
%% Figure 3h
clear;clc
turning_angle = 75;
standard_sig_file = "../data/collective_turns_data/standard_signal_ta=" + num2str(turning_angle) + ".mat";
load(standard_sig_file)
% theta_info = 75
load("../data/collective_turns_data/group_response_signals.mat")
colorlist_1 = [254,229,217
252,174,145
251,106,74
203,24,29]./255;
colorlist_2 = [239,243,255
189,215,231
107,174,214
33,113,181]./255;
cal_ped_list = [50:10:100];
mean_cos_heading_AMS = mean_cos_heading_AMS_cell{1};
mean_cos_heading_NMS = mean_cos_heading_NMS_cell{1};
mean_cos_heading_Ave = mean_cos_heading_Ave_cell{1};

mean_cos_heading_AMS_tmp = mean_cos_heading_AMS{end}; % 1-none noise end-maximal noise
mean_cos_heading_NMS_tmp = mean_cos_heading_NMS{end};
mean_cos_heading_Ave_tmp = mean_cos_heading_Ave{end};

figure
figSize_L = 48;
figSize_W = 5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
plot([1:500] * 0.2, mean_cos_heading_AMS_tmp(1:500,1), 'LineWidth',1,'Color',colorlist_1(end,:))
hold on
plot([1:500] * 0.2, mean_cos_heading_NMS_tmp(1:500,1), 'LineWidth',1,'Color',colorlist_2(end,:))
hold on
plot([1:500] * 0.2, mean_cos_heading_Ave_tmp(1:500,1), 'LineWidth',1,'Color',[127, 127, 127]./255)
hold on
plot([1:500] * 0.2, stand_cos_heading(1,1:500), '-k', 'LineWidth',0.5)
xlim([0, 100])
%         ylim([0, 1])
xlabel("time [s]")
ylabel("$cos(\theta(t))$", 'Interpreter','latex')
legend(["WSIN", "PNIN", "FCIN", "standard signal"],'Location','bestoutside','Box','off')
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)