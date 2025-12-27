%% Figure 2d
% This MATLAB code generates several figures (2d, 2g, 2e, 2f) related to the dynamics of an SIR (Susceptible-Infected-Recovered) model, 
% exploring how various parameters such as mutation rate, infection rate, and group size affect the spread of an infectious disease. 
% The code contains loops to process the results for different mutation rates, infection rates, and group sizes. 
%% Figure 2g
clear;clc;
addpath("../data/SIR_data/")
addpath("../utility/")
mute_list = [0:0.1:1];
load("../data/SIR_data/Fig2g_data.mat")
figure
figSize_L = 5;
figSize_W = 4.5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
mycolor = [254,196,79
254,153,41
236,112,20
204,76,2]./255;
draw_mutateRate = [0, 0.1, 0.3, 1];
for k = 1:length(draw_mutateRate)
    k_idx = find(abs(draw_mutateRate(k) - mute_list) < 1e-6);
    hold on
    if k == 4
        e(k) = errorbar(draw_time_cell_4{1}, draw_num_infected_ave_4{1}, ...
            high_CI_cell_4{1},lower_CI_cell_4{1}, ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
        hold on
        errorbar(draw_time_cell_4{2}, draw_num_infected_ave_4{2}, ...
            high_CI_cell_4{2}, lower_CI_cell_4{2}, ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
    else
        e(k) = errorbar(draw_time_cell{k_idx}, draw_num_infected_ave_cell{k_idx}, ...
            draw_high_CI_cell{k_idx},draw_low_CI_cell{k_idx}, ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
    end
    hold on 
end
box on
xlim([0, 51])
xlabel("time [s]")
ylabel("$\rho_{\rm{infected}}$",'interpreter','latex')
legend(e, ["$\psi=$" + draw_mutateRate'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% Figure 2e
clear;clc;
N = 100;
load("../data/SIR_data/Fig2e_data.mat");
infRate_list = [0.3:0.1:0.5];
mute_list = [0:0.1:1];
figure
figSize_L = 5;
figSize_W = 4;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
mycolor = [107,174,214
66,146,198
33,113,181]./255;
for infRate = infRate_list
    infRate_idx = find(infRate == infRate_list);
    p_e(infRate_idx) = errorbar(mut_cell{infRate_idx} , num_infected_ave_cell{infRate_idx}, ...
        lower_CI_cell{infRate_idx}, high_CI_cell{infRate_idx}, 'Color',mycolor(infRate_idx,:),'LineWidth',1,'Marker','o','MarkerSize',3.5);
    hold on
end
xlabel("$\psi$",'Interpreter','latex')
ylabel("$\rho_{\rm{infected}}$",'Interpreter','latex')
legend(p_e, ["$\beta_{max}=$" + infRate_list'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% Figure 2f
clear;clc;
infRate_list = [0.3:0.1:0.5];
recRate = 0.05;
infNum_list = [1];
mute_list = [0:0.1:1];
load("../data/SIR_data/Fig2f_data.mat");
figure
figSize_L = 5;
figSize_W = 4;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
mycolor = [107,174,214
66,146,198
33,113,181]./255;
for infRate = infRate_list
    infRate_idx = find(infRate == infRate_list);
    p_e(infRate_idx) = errorbar(mute_cell{infRate_idx}, max_num_infected_ave_cell{infRate_idx}, ...
        lower_CI_cell{infRate_idx}, high_CI_cell{infRate_idx}, 'Color',mycolor(infRate_idx,:),'LineWidth',1,'Marker','o','MarkerSize',3.5);
    hold on
end
xlabel("$\psi$",'Interpreter','latex')
ylabel("maximum infected individual")
legend(p_e, ["$\beta_{\rm{max}}=$" + infRate_list'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% The effect of N on the fully activated time all infection rates
clear;clc;
load("../data/SIR_data/Fig2i_data.mat")
figure
figSize_L = 8;
figSize_W = 8.5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
g=gramm('x',inf_rate_x,'y',all_finish_tmp,'color',group_c);
g.stat_summary('geom',{'bar','black_errorbar'},'type','ci');
g.set_names('x','maximal infected rate','y','finish time [s]','color','group size');
g.set_color_options('map','brewer2');
g.axe_property('box','on')
g.draw();
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
