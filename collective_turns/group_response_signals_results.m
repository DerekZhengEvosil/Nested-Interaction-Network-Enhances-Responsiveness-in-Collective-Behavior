%% Figure 3b
% This MATLAB code produces several plots that illustrate the relationship between the response accuracy and other factors like the turning angle for collective turns experiments. 
% The figures are separated by different turning angles and experimental conditions, and the plots aim to show how different factors affect collective movement accuracy.
clear;clc;
addpath("../data/SIR_data/") % load the necessarty data for reproude the results of collective turns from the perspective of group response signals;
addpath("../utility/") % load necessarty tool codes
colorlist_1 = [254,229,217
252,174,145
251,106,74
203,24,29]./255;

colorlist_2 = [239,243,255
189,215,23
107,174,214
33,113,181]./255;
drawResults = struct;
% theta_info = 45
% The following codes required the intalled or added gramm2;
load("../data/collective_turns_data/theta_info_45_no_noise_S_wave.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); 
g.set_names('x', '$T_{\rm{info}}$', 'y', '$S_{\rm{wave}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 300]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();

% theta_info = 60
load("../data/collective_turns_data/theta_info_60_no_noise_S_wave.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); %
g.set_names('x', '$T_{\rm{info}}$', 'y', '$S_{\rm{wave}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 300]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();

% theta_info = 75
load("../data/collective_turns_data/theta_info_75_no_noise_S_wave.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); % 
g.set_names('x', '$T_{\rm{info}}$', 'y', '$S_{\rm{wave}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 300]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();
%% Figure 3c
% theta_info = 45
load("../data/collective_turns_data/theta_info_45_no_noise_delta_peak.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); % 
g.set_names('x', '$T_{\rm{info}}$', 'y', '$\Delta\epsilon_{\rm{peak}}/T_{\rm{info}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 1]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();

% theta_info = 60
load("../data/collective_turns_data/theta_info_60_no_noise_delta_peak.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); % 
g.set_names('x', '$T_{\rm{info}}$', 'y', '$\Delta\epsilon_{\rm{peak}}/T_{\rm{info}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 1]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();

% theta_info = 75
load("../data/collective_turns_data/theta_info_75_no_noise_delta_peak.mat")
g = gramm('x',drawResults.big_categ','y',drawResults.result', 'color', drawResults.colors');
g.stat_summary('geom',{'bar','black_errorbar'},'setylim','true');
% g.stat_violin('normalization','width');
g.set_text_options('interpreter', 'latex','base_size',7)
g.axe_property('box', 'on'); % 
g.set_names('x', '$T_{\rm{info}}$', 'y', '$\Delta\epsilon_{\rm{peak}}/T_{\rm{info}}$','color', "Type",'label',{}) 
g.set_title('');
g.axe_property('YLim', [0, 1]);
g.set_order_options('color', ["PNIN" "WSIN" "FCIN"]);
g.set_color_options('map', [colorlist_2(end,:); colorlist_1(end,:);[135,135,135]./255])
figure;
figSize_L = 5;
figSize_W = 3;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g.draw();
%% Figure 3d
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
for ped = [50, 100] % 50 * 0.2 = 10s,100 * 0.2 = 20s
    p_idx = find(ped == cal_ped_list);
    mean_cos_heading_AMS = mean_cos_heading_AMS_cell{p_idx};
    mean_cos_heading_NMS = mean_cos_heading_NMS_cell{p_idx};
    mean_cos_heading_Ave = mean_cos_heading_Ave_cell{p_idx};

    mean_cos_heading_AMS_tmp = mean_cos_heading_AMS{1}; % 1-none noise end-maximal noise
    mean_cos_heading_NMS_tmp = mean_cos_heading_NMS{1};
    mean_cos_heading_Ave_tmp = mean_cos_heading_Ave{1};
    
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
    plot([1:500] * 0.2, stand_cos_heading(p_idx,1:500), '-k', 'LineWidth',0.5)
    xlim([0, 100])
%         ylim([0, 1])
    xlabel("time [s]")
    ylabel("$cos(\theta(t))$", 'Interpreter','latex')
    legend(["WSIN", "PNIN", "FCIN", "standard signal"],'Location','bestoutside','Box','off')
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
end
