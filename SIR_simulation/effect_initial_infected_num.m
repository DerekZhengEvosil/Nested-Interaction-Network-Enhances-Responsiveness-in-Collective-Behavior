%% codes for reproducing the Fig.2j
clear;clc
mute_list = [0:0.1:1];
load("../data/SIR_data/data_effect_of_infected_num.mat")
figure
figSize_L = 6;
figSize_W = 8.5;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
mycolor = [253,187,132
252,141,89
239,101,72
215,48,31
179,0,0]./255;
draw_cnt = 0;
draw_mutateRate_list = [0.1, 0.2, 0.3, 0.6, 1];
draw_infNum_list = [1:50];
for draw_mutateRate = draw_mutateRate_list
    k_idx = find(abs(draw_mutateRate - mute_list) < 1e-16);
    draw_cnt = draw_cnt + 1;

    infected_ave_mut= infected_ave_mut_cell{k_idx};
    high_CI_mut= high_CI_mut_cell{k_idx};
    lower_CI_mut = lower_CI_mut_cell{k_idx};
    
    e(draw_cnt) = errorbar(draw_infNum_list, infected_ave_mut, ...
        high_CI_mut,lower_CI_mut, ...
            'Color',mycolor(draw_cnt,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',5);
    hold on 
end
box on
xlim([1,20])
ylim([0, 1])
xlabel("$N_{\rm{init}}$",'interpreter','latex')
ylabel("$\rho_{\rm{infected}}$",'interpreter','latex')
legend(e, ["\psi=" + draw_mutateRate_list'],'box','off','Location','best');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
