function gen_acc_r_freq_patch(folder_name, record_video, plot_figure, align_type, episode_idx, freq, ymp, ymn)
% disp(folder_name)
addpath("../utility/")
txtFiles = dir(folder_name);
G = struct;
G.cycTime = 0.2;
G.BL = 1; % meter
for i = 2:length(txtFiles)
    param = split(txtFiles(i).name, '_');
    if param{1} == "simData"
        robotId = str2double(erase(param{2}, ".txt")) + 1;
        G.actor{robotId}.memory = load([folder_name + '/' + txtFiles(i).name]);
    end
end
G.num = length(G.actor);
for i = 1:G.num
    len = size(G.actor{i}.memory,1);
    savingData(1:len,i,1:2)=G.actor{i}.memory(:,1:2)./ G.BL;
    savingData(1:len,i,3) = cos(G.actor{i}.memory(:,3) - pi/2);
    savingData(1:len,i,4) = sin(G.actor{i}.memory(:,3) - pi/2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% G.Enter_height = 1800;
G.expNum = G.num;
G.align_type = align_type;
G.total_step = size(savingData,1);
op = [];
nnd = [];
r_acc = zeros(1, size(savingData,1));
informed_r_acc = zeros(1, size(savingData,1));
informed_id_file = load([folder_name + '/' + "informed_id.mat"]);
informed_id = double(informed_id_file.informed_id);
resp_file = load([folder_name + '/' + 'informed_vel.mat']);
resp_dir = resp_file.informed_vel';
informed_id = informed_id + 1;
informed_cnt = 0;
for t = 1:size(savingData,1)
    if mod(t-1, freq) == 0
        if mod(informed_cnt, 2) == 0
            informed_dir = resp_dir(:, 1);
        elseif mod(informed_cnt, 2) == 1
            informed_dir = resp_dir(:, 2);
        end
        informed_cnt = informed_cnt + 1;
    end
    G.robotsPosH = squeeze(savingData(t,:,1:4));
    all_pos = G.robotsPosH(1:G.expNum, [1:2])';
    all_vel = G.robotsPosH(1:G.expNum, [3:4])';
end

G.r_agent = 0.05;
if plot_figure == 1
    figure;
    figSize_L = 6.5;
    figSize_W = 6.5;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    axis equal
    hold on;box on;
    traj = savingData;
    x = squeeze(traj(1:G.total_step,:,1));
    y = squeeze(traj(1:G.total_step,:,2));
    v_x = squeeze(traj(1:G.total_step,:,3));
    v_y = squeeze(traj(1:G.total_step,:,4));
%     text(x(1,:), y(1,:), num2str([1:G.expNum]'),'HorizontalAlignment','center')
    end_step = 1000;
    for p = 1:size(x,2)
        patch([x(1:end_step,p)' NaN], [y(1:end_step,p)' NaN], [[1:end_step]/(end_step - 1)  NaN], ...
                                    'EdgeColor','flat','MarkerFaceColor','flat','LineWidth',0.5)
%         plot(x(1:end_step,p), y(1:end_step,p),"Color",[186,186,186]./255,'LineWidth',1,'LineStyle','-')
        hold on
    end
    ylim([ymn, ymp])
    xlim([-1.5, 4])
    patch([nanmean(x(1:end_step,:),2)' NaN], [nanmean(y(1:end_step,:), 2)' NaN], [[1:end_step]/(end_step - 1)  NaN], ...
                                    'EdgeColor','flat','MarkerFaceColor','flat','LineWidth',0.5)
    hold on
    my_map = slanCM(134);
%     quiver(x(end_step,:), y(end_step,:), v_x(end_step,:), v_y(end_step,:),0.4,'color','k','linewidth',0.25);
%     hold on;
%     arrayfun(@(x,y) rectangle('Position', [x-G.r_agent, y-G.r_agent, G.r_agent*2, G.r_agent*2],...
%         'Curvature', [1 1], 'EdgeColor', 'none', 'FaceColor', [my_map(end,:) 1]), x(end_step,:), y(end_step,:))
%     quiver(x(end_step,:), y(end_step,:), v_x(end_step,:), v_y(end_step,:),0.4,'color','k','linewidth',0.25);
%     hold on;
%     arrayfun(@(x,y) rectangle('Position', [x-G.r_agent, y-G.r_agent, G.r_agent*2, G.r_agent*2],...
%         'Curvature', [1 1], 'EdgeColor', [hex2rgb('262626') 0.7], 'FaceColor', [hex2rgb('ffa500') 1]), ...
%         x(end_step,:), y(end_step,:))
    colormap(my_map)
    xlabel('x [m]');
    ylabel('y [m]');
    set(gca, 'Fontname', 'helvetica', 'FontSize', 7)
end
end
