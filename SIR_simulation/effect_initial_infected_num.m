%% Figure 2g
% This MATLAB code generates Figure 2g, which explores the relationship between the initial number of infected individuals and the final infected proportion 
% under varying mutation rates in a SIR (Susceptible-Infected-Recovered) model. 
clear;clc;
N = 100;
infRate_list = [0.5];
recRate = 0.05;
infNum_list = [1:50];
mute_list = [0:0.1:1];
addpath("../utility/")
for infRate = infRate_list
    dataFolder = "../data/SIR_data/initial_informed_num_result";
    for infNum = infNum_list 
        inf_idx = find(infNum == infNum_list);
        load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
        nestedness = Data{1};
        num_infected = Data{2};
        num_rec = Data{3};
        time_list = Data{4};
        mutate_rate = Data{5};
        lower_CI = [];
        num_infected_ave = [];
        high_CI = [];
        for muteRate = mute_list
            mut_idx = find(muteRate==mute_list);
            nestedness_ave(mut_idx) = nanmean(nestedness{mut_idx});
            infected_tmp = num_infected{1,mut_idx};
            rec_tmp = num_rec{1, mut_idx};
            num_infected_ave(mut_idx,:) = nanmean(infected_tmp + rec_tmp,1)./N;
            num_infected_std(mut_idx,:) = nanstd(double(infected_tmp+rec_tmp),1)./N;
            meanData = nanmean(infected_tmp + rec_tmp,1)./N;
            stdData = nanstd(double(infected_tmp+rec_tmp),1)./N;
            n = size(infected_tmp + rec_tmp, 1); 
            stdError = stdData / sqrt(n);
            confidenceLevel = 0.95;
            z = norminv((1 + confidenceLevel) / 2, 0, 1); 
            marginOfError = z * stdError;
            lower_CI(mut_idx,:) = marginOfError;
            high_CI(mut_idx,:) =  marginOfError;
            time_ave(mut_idx,:) = nanmean(time_list{1,mut_idx},1);
        end
        num_infected_ave_infNum{inf_idx} = num_infected_ave;
        lower_CI_infNum{inf_idx} = lower_CI;
        high_CI_infNum{inf_idx} = high_CI;
    end
end
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
    for infNum = draw_infNum_list 
        inf_idx = find(infNum == draw_infNum_list);
        num_infected_ave = num_infected_ave_infNum{inf_idx};
        high_CI = high_CI_infNum{inf_idx};
        lower_CI = lower_CI_infNum{inf_idx};
        infected_ave_mut(inf_idx) = num_infected_ave(k_idx,152);
        high_CI_mut(inf_idx) = high_CI(k_idx,152);
        lower_CI_mut(inf_idx) = lower_CI(k_idx,152);
    end
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
