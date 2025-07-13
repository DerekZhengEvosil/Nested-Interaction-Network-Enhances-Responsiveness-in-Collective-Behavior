%% Figure 2d
% This MATLAB code generates several figures (2d, 2g, 2e, 2f) related to the dynamics of an SIR (Susceptible-Infected-Recovered) model, 
% exploring how various parameters such as mutation rate, infection rate, and group size affect the spread of an infectious disease. 
% The code contains loops to process the results for different mutation rates, infection rates, and group sizes. 
clear;clc;
N = 100;
addpath("../utility/")
dataFolder = "../data/SIR_data/result_N=100_th=0.3";
infRate_list = [0.5];
recRate = 0.05; % recovered rate
infNum_list = [1]; % initial activation number of node
mute_list = round(linspace(0,1,10),1);
for infRate = infRate_list
    for infNum = infNum_list 
        load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
        nestedness = Data{1};
        num_infected = Data{2}; % number of infected node
        num_rec = Data{3}; % number of recoverd node
        time_list = Data{4}; % temporal time in simulations
        mutate_rate = Data{5}; % mutation condition
        for muteRate = mute_list
            mut_idx = find(muteRate==mute_list);
            nestedness_ave(mut_idx) = nanmean(nestedness{mut_idx});
            infected_tmp = num_infected{1,mut_idx};
            rec_tmp = num_rec{1, mut_idx};
            num_infected_ave(mut_idx,:) = nanmean(infected_tmp,1);
            num_rec_ave(mut_idx,:) = nanmean(rec_tmp,1);
            num_sus_ave(mut_idx,:) = nanmean(N - (infected_tmp + rec_tmp), 1); % the number of susceptible state
            time_ave(mut_idx,:) = nanmean(time_list{1,mut_idx},1);
        end
    end
end
draw_mutateRate = [0,0.1,0.3,1];
colorlist = [102,194,165
252,141,98
141,160,203]./255;
for k = 1:length(draw_mutateRate)
    figure
    figSize_L = 5;
    figSize_W = 4;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    k_idx = find(draw_mutateRate(k) == mute_list);
    p1 = plot(time_ave(k_idx,1:752), num_sus_ave(k_idx,1:752),'-','Color', colorlist(1,:),'lineWidth',2);
    sus_zero = min(num_sus_ave(k_idx,1:752),1);
    xline(time_ave(k_idx,sus_zero))
    hold on
    p2 = plot(time_ave(k_idx,1:752), num_infected_ave(k_idx,1:752),'-','Color', colorlist(2,:),'lineWidth',2);
    hold on
    p3 = plot(time_ave(k_idx,1:752), num_rec_ave(k_idx,1:752),'-','Color', colorlist(3,:),'lineWidth',2);
    hold on
    xlim([0, 50])
    xlabel("time [s]")
    ylabel("number of individual")
    legend([p1,p2,p3], ["susceptible", "infected", "recovered"],'box','off','Location','best');
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
end
%% Figure 2g
clear;clc;
addpath("../data/SIR_data/")
addpath("../utility/")
N = 100;
dataFolder = "../data/SIR_data/result_N=" + num2str(N) + "_th=0.3";
infRate_list = [0.5];
recRate = 0.05;
infNum_list = [1];
mute_list = [0:0.1:1];
for infRate = infRate_list
    for infNum = infNum_list 
        load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
        nestedness = Data{1};
        num_infected = Data{2};
        num_rec = Data{3};
        time_list = Data{4};
        mutate_rate = Data{5};
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
    end
end
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
        e(k) = errorbar(time_ave(k_idx,[1:15:120, 150]), num_infected_ave(k_idx,[1:15:120, 150]), ...
            high_CI(k_idx,[1:15:120, 150]),lower_CI(k_idx,[1:15:120, 150]), ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
        hold on
        errorbar(time_ave(k_idx,[150:50:752, 752]), num_infected_ave(k_idx,[150:50:752, 752]), ...
            high_CI(k_idx,[150:50:752, 752]),lower_CI(k_idx,[150:50:752, 752]), ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
    else
        e(k) = errorbar(time_ave(k_idx,[1:50:752,752]), num_infected_ave(k_idx,[1:50:752,752]), ...
            high_CI(k_idx,[1:50:752,752]),lower_CI(k_idx,[1:50:752,752]), ...
                'Color',mycolor(k,:),'LineWidth',1,'Marker','s','LineStyle','-','MarkerSize',3.5);
    end
    hold on 
    nestedness_draw(k) = nestedness_ave(k_idx);
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
addpath("../utility/")
dataFolder = "../data/SIR_data/result_N=100_th=0.3";
infRate_list = [0.3:0.1:0.5];
recRate = 0.05;
infNum_list = [1];
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
    for infNum = infNum_list 
        load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
        nestedness = Data{1};
        num_infected = Data{2};
        num_rec = Data{3};
        time_list = Data{4};
        mutate_rate = Data{5};
        for muteRate = mute_list
            mut_idx = find(muteRate==mute_list);
            nestedness_ave(mut_idx) = nanmean(nestedness{mut_idx});
            infected_tmp = num_infected{1,mut_idx};
            rec_tmp = num_rec{1, mut_idx};
            infected_rate_tmp = [];
            for k = 1:size(infected_tmp, 1)
                tmp1 = (infected_tmp(k, 752) + rec_tmp(k,752))./N; % when step=752, time elapsing 50 seconds
                infected_rate_tmp(k) = tmp1;
            end

            num_infected_ave(mut_idx,:) = nanmean(infected_rate_tmp);
            num_infected_std(mut_idx,:) = nanstd(infected_rate_tmp);
            meanData = nanmean(infected_rate_tmp);
            stdData = nanstd(infected_rate_tmp);
            n = size(infected_rate_tmp, 2);
            stdError = stdData / sqrt(n);
            confidenceLevel = 0.95;
            z = norminv((1 + confidenceLevel) / 2, 0, 1);
            marginOfError = z * stdError;
            lower_CI(mut_idx,:) = marginOfError;
            high_CI(mut_idx,:) =  marginOfError;
            time_ave(mut_idx,:) = nanmean(time_list{1,mut_idx},1);
        end
    end
    p_e(infRate_idx) = errorbar(mute_list([1:1:end,end]), num_infected_ave([1:1:end,end]), ...
        lower_CI([1:1:end,end]), high_CI([1:1:end,end]), 'Color',mycolor(infRate_idx,:),'LineWidth',1,'Marker','o','MarkerSize',3.5);
    hold on
end
xlabel("$\psi$",'Interpreter','latex')
ylabel("$\rho_{\rm{infected}}$",'Interpreter','latex')
legend(p_e, ["$\beta_{max}=$" + infRate_list'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% Figure 2f
clear;clc;
addpath("../utility/")
dataFolder = "../data/SIR_data/result_N=100_th=0.3";
infRate_list = [0.3:0.1:0.5];
recRate = 0.05;
infNum_list = [1];
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
    for infNum = infNum_list 
        load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
        nestedness = Data{1};
        num_infected = Data{2};
        num_rec = Data{3};
        time_list = Data{4};
        mutate_rate = Data{5};
        for muteRate = mute_list
            mut_idx = find(muteRate==mute_list);
            nestedness_ave(mut_idx) = nanmean(nestedness{mut_idx});
            infected_tmp = num_infected{1,mut_idx};
            rec_tmp = num_rec{1, mut_idx};
            max_num_infected_tmp = [];
            for k = 1:size(infected_tmp, 1)
                max_num_infected_tmp(k) = max(infected_tmp(k, :));
            end
            max_num_infected_ave(mut_idx,:) = nanmean(max_num_infected_tmp);
            max_num_infected_std(mut_idx,:) = nanstd(double(max_num_infected_tmp));
            max_num_infected_ave(mut_idx,:) = nanmean(max_num_infected_tmp);
            max_num_infected_std(mut_idx,:) = nanstd(double(max_num_infected_tmp));
            meanData = nanmean(max_num_infected_tmp);
            stdData = nanstd(double(max_num_infected_tmp));
            n = size(max_num_infected_tmp, 2);  % 样本数量
            stdError = stdData / sqrt(n);
            confidenceLevel = 0.95;
            z = norminv((1 + confidenceLevel) / 2, 0, 1);  % Z 值
            marginOfError = z * stdError;
            lower_CI(mut_idx) = marginOfError;
            high_CI(mut_idx) = marginOfError;
            time_ave(mut_idx,:) = nanmean(time_list{1,mut_idx},1);
        end
    end
    p_e(infRate_idx) = errorbar(mute_list([1:1:end,end]), max_num_infected_ave([1:1:end,end]), ...
        lower_CI([1:1:end,end]), high_CI([1:1:end,end]), 'Color',mycolor(infRate_idx,:),'LineWidth',1,'Marker','o','MarkerSize',3.5);
    hold on
end
xlabel("$\psi$",'Interpreter','latex')
ylabel("maximum infected individual")
legend(p_e, ["$\beta_{\rm{max}}=$" + infRate_list'],'box','off','Location','best','Interpreter','latex');
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% The effect of N on the fully activated time all infection rates
clear;clc;
addpath("../utility/")
all_finish_tmp = [];
inf_rate_x = [];
group_c = [];
for recRate = [0.05]
    violin_data = [];
    N_list = [50, 100, 150, 200];
    for N = N_list
        N_idx = find(N == N_list);
        dataFolder = "../data/SIR_data/result_N=" + num2str(N) + "_th=0.3";
        infRate_list = [0.3, 0.4, 0.5];
        infNum_list = [1];
        mute_list = [0];
        for infRate = infRate_list
            for infNum = infNum_list 
                load(dataFolder + "/SIR_result_EXP_" + "infRate=" + num2str(infRate) + "-recRate=" + num2str(recRate) + "-infNum=" + num2str(infNum) + ".mat")
                nestedness = Data{1};
                num_infected = Data{2};
                num_rec = Data{3};
                time_list = Data{4};
                mutate_rate = Data{5};
                for muteRate = mute_list
                    mut_idx = find(muteRate==mute_list);
                    time_ave(mut_idx,:) = nanmean(time_list{1,mut_idx},1);
                    nestedness_ave(mut_idx) = nanmean(nestedness{mut_idx});
                    infected_tmp = num_infected{1, mut_idx};
                    rec_tmp = num_rec{1, mut_idx};
                    all_infected = infected_tmp + rec_tmp;
                    finish_time_tmp = [];
                    for k = 1:size(all_infected, 1)
                        time_idx = find(double(all_infected(k, :)) == N, 1);
                        if ~isempty(time_idx)
                            finish_time_tmp(k) = time_ave(mut_idx, time_idx);
                        else
                            finish_time_tmp(k) = nan;
                        end
                    end
                    finish_time_tmp_sort = sort(finish_time_tmp, 'ascend');
                    all_finish_tmp = [all_finish_tmp  finish_time_tmp_sort(1:50)];
                    inf_rate_x = [inf_rate_x, cellstr(string(ones(1,50)*infRate))];
                    group_c = [group_c, ones(1,50)* N_idx];
                end
            end
        end
    end
end
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
