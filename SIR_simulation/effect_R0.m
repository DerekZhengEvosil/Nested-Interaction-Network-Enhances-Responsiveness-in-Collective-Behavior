%% Figure 2h
% The purpose of this MATLAB code is to create Figure 2h, 
% which explores the relationship between the basic reproduction number (R_0) and the final infected proportion in a Susceptible-Infected-Recovered (SIR) model. 
% This figure shows how mutation rates affect the final proportion of infected individuals as a function of R_0, with confidence intervals represented as shaded regions.
clear;clc;
addpath("../data/SIR_data/")
addpath("../utility/")
load("../data/SIR_data/R0_data.mat")
figure
figSize_L = 5;
figSize_W = 4.5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
mycolor = [254,196,79
254,153,41
236,112,20
204,76,2]./255;
mute_list = [0, 0.1, 0.3, 1];
recRate_list = [0.001:0.001:0.5];
R_0 = 0.5./recRate_list;
flip_R0 = fliplr(R_0);
first_stop = find(flip_R0 == 2);
stop_idx = 468;
draw_mute_list = fliplr(mute_list);
R0_value = [];
cnt = 0;
th = 0.9;
for muteRate = draw_mute_list
    cnt = cnt + 1;
    mute_idx = find(muteRate == mute_list);
    ave_final_infected = fliplr(num_infected_ave_cell{mute_idx}');
    std_final_infected =  num_infected_std_cell{mute_idx};
    high_CI_tmp = high_CI_cell{mute_idx};
    low_CI_tmp = low_CI_cell{mute_idx};
    rec_scatter_tmp = rec_scatter_cell{mute_idx};
    num_infected_ave_scatter_tmp = num_infected_ave_scatter_cell{mute_idx};
    scatter(flip_R0(1:5:first_stop), ave_final_infected(1:5:first_stop), 8, 'MarkerFaceColor',mycolor(mute_idx,:),'MarkerEdgeColor','none','MarkerFaceAlpha', 0.3);
    hold on
    scatter(flip_R0(first_stop:stop_idx), ave_final_infected(first_stop:stop_idx), 8, 'MarkerFaceColor',mycolor(mute_idx,:),'MarkerEdgeColor','none','MarkerFaceAlpha', 0.3);
    hold on
    smooth_tmp = smoothdata(ave_final_infected([1:1:stop_idx, stop_idx]),"gaussian");
    e(mute_idx) = plot(flip_R0([1:1:stop_idx, stop_idx]), smooth_tmp, ...
        'Color',mycolor(mute_idx,:),'LineWidth',2,'Marker','none','LineStyle','-','MarkerSize',10);
    hold on
    R0_value(cnt) = flip_R0(find(smooth_tmp>th, 1));
    fill([flip_R0, fliplr(flip_R0)], [fliplr(smooth(high_CI_tmp', 20)'), smooth(low_CI_tmp', 20)'], ...
        mycolor(mute_idx,:), 'FaceAlpha', 0.3, 'EdgeColor', 'none');
    hold on
    hold on
    xlim([1, 15])
    ylim([0.2,1])
end
box on
hold on
xlabel("$R_0$",'Interpreter','latex')
ylabel("$\rho_{\rm{infected}}$",'Interpreter','latex')
legend(e, ["$\psi=$" + mute_list'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
