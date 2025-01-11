% ******************* 显示机器人运动状态 **********************
function c_k = drawRobotsTraj_hovering_info(G)
    dt = G.cycTime;
    tos = G.simStep;
    % --------- 计算相关统计量 ---------    
    heading = nan * zeros(G.simStep,G.maxID);
    speed = nan * zeros(G.simStep,G.maxID);
    rotRate = nan * zeros(G.simStep,G.maxID);
    flockpos = nan * zeros(G.simStep,2);
    respondness = nan * zeros(G.simStep,1);
    outside_number = nan * zeros(G.simStep,1);

    lost_ids = [];
    for i = 1:G.expNum
        if length(find(isnan(G.actor{i}.memory(:,[1,2]))) > 1)
            lost_ids = [lost_ids, i];
        end
    end


    for t = 1:G.simStep
        posDir = [];
        p_posDir = [];
        for i = 1:G.expNum
            heading(t,i) = vel2heading_deg(G.actor{i}.memory(t,[3,4]));
            posDir(i,[1,2,3,4]) = G.actor{i}.memory(t,[1,2,3,4]);
            if t>=2
                p_posDir(i,[1,2,3,4]) = G.actor{i}.memory(t-1,[1,2,3,4]);
                speed(t,i) = norm(posDir(i,[1,2])-p_posDir(i,[1,2]))/dt;
                rotRate(t,i) = acosd(dot(posDir(i,[3,4]),p_posDir(i,[3,4])))/dt;
            end
        end
        temp_a = find(abs(posDir(:,[1])) > G.Lx/2);
        temp_b = find(abs(posDir(:,[2])) > G.Ly/2);
        if ~isempty(temp_a) || ~isempty(temp_b)
           outside_number(t)  = length(temp_a) + length(temp_b);
        elseif ~isempty(temp_a) && ~isempty(temp_b)
            outside_number(t)  = length(intersect(find(abs(posDir(:,[1])) > G.Lx/2), find(abs(posDir(:,[2])) > G.Ly/2)));
        else
            outside_number(t) = 0;
        end

        flockpos(t,:) = nanmean(posDir(setdiff([1:G.expNum], lost_ids),[1,2]),1);
    end
    
    smooth_flock_pos = [movmean(flockpos(:,1),50), movmean(flockpos(:,2),50)];
    %%% calculate the curvature
    h=1;
    used_flockpos = flockpos;
    used_flockpos(:,3) = 0;
    r=used_flockpos';                         %表示函数
    r1=gradient(r)./h;            % 求一阶导
    r2=gradient(r1)./h;           % 二阶导
    r1=r1';r2=r2';
    v=cross(r1,r2,2);        
    c=zeros(length(t),1);        
    d=c;
    for i=1:length(r)
        c(i)=norm(v(i,:));           %一阶导二阶导外积的模长
        d(i)=norm(r1(i,:));          %一阶导模长
    end 
    c_k = (c./(d.^3));                     % 曲线上每一点的曲率：一阶导与二阶导的叉乘的模除以一阶导模的三次方
    M_index = nanmean(c_k);
    
%     % --------- 绘图窗口设置 ---------
    figure('posi',[100,200,1000,600]);   	% 主窗口句柄
    h_trajAxes = axes('Posi',[0.05 0.08 0.5 0.9]);    	% 机器人轨迹显示
    xlim([-3000,3000]); ylim([-3000,3000]); 
    h_speedAxes = axes('Posi',[0.6 0.82 0.35 0.15]);    % 机器人线速度显示 
    h_headingAxes = axes('Posi',[0.6 0.57 0.35 0.15]);	% 机器人朝向显示 
    h_respondAxes = axes('Posi',[0.6 0.33 0.35 0.15]);	% 机器人角速度显示      
    h_opAxes = axes('Posi',[0.6 0.08 0.35 0.15]);       % 群体序参量显示
    
    % ------------  主窗口 --------------
    % 绘制：机器人位置、heading、轨迹    
    r = 30;             % 机器人半径mm
    arrow_scale = 30;   % 机器人heading
    axes(h_trajAxes); box on; grid on; axis equal; 
    for i = 1:G.expNum
        pos = G.actor{i}.pose;
        vel = G.actor{i}.vel;
        tailTraj = G.actor{i}.memory(:,[1,2]);
        if ~isnan(pos)
            % 显示机器人运动轨迹
            quiver(pos(1),pos(2),arrow_scale*vel(1),arrow_scale*vel(2),0,'k','linewidth',1); hold on;
            line(tailTraj(1:tos,1),tailTraj(1:tos,2),'linestyle','-','linewidth',0.5); hold on;
            rectangle('Position', [pos(1)-r, pos(2)-r, r*2, r*2], 'Curvature', [1 1]); hold on;
        end
    end
    % 绘制：群体中心
    line(flockpos(1:tos,1),flockpos(1:tos,2),'linestyle','-','linewidth',1.5,'color',[0,0,1]); hold on;
    % 绘制：场地边界
    rectangle('Position', [-2790,-2890,5380, 5680], 'Curvature', [0 0],'linewidth',2); hold on;
%     rectangle('Position', [-2100,-2350,4200, 4700], 'Curvature', [0 0],'linewidth',3,'edgecolor',[0,0,1]); hold on;
    rectangle('Position', [-G.Lx/2,-G.Ly/2,G.Lx, G.Ly], 'Curvature', [0 0],'linewidth',3,'edgecolor',[0,0,1]); hold on;
    % draw the obstacle
    hold on;
    if isfield(G,'obstacles_pos')
        arrayfun(@(x,y,z) rectangle('Position', [x-z, y-z, z, z],...
                'Curvature', [1 1], 'EdgeColor', 'n', 'FaceColor', 'k'), G.obstacles_pos(:,1), G.obstacles_pos(:,2), G.obstacles_size')
    end
    % 绘制：个体的感知范围（id=1）
%     if isfield(G,'r_sense')
%         pos = G.actor{1}.pose;
%         r = G.r_sense;
%         rectangle('Position', [pos(1)-r, pos(2)-r, r*2, r*2], 'Curvature', [1 1],'edgecolor',[0,1,0]); hold on;
%     end
    box on; grid on; axis equal; 
    
    % ------------- 辅助窗口 ------------
    % 显示：op曲线
    axes(h_opAxes); 
    box on; grid on; xlabel('time/step'); ylabel('op'); ylim([0,1]);
    h_op = line([1:tos],G.op(1,1:tos),'linestyle','-','linewidth',1); hold on;
    title(['mean op=',num2str(mean(G.op))])
    % 显示：heading曲线
    axes(h_headingAxes);
    plot([1:tos],heading(1:tos,:)); hold on;
%     plot([1:G.simStep],heading(:,infoID),'linewidth',1,'color',[1,0,0]); hold on;
    xlabel('steps');
    ylabel('heading(deg)');
    % 显示：respondness曲线
    axes(h_respondAxes);
    plot([1:tos],outside_number(1:tos)); hold on;
    xlabel('steps');
    ylabel('outside number');
    title(['outside number=',num2str(nansum(outside_number))]);

    axes(h_speedAxes)
    plot(c_k(10:1:tos));
    xlabel('steps');
    ylabel('curvature');
    title(['curvature=',num2str(trapz(c_k))]);

    figure
    figSize_L = 4.7;
    figSize_W = 3;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    plot([10:1:tos].*dt, c_k(10:1:tos));
    ax = gca;
    ax.YAxis.Exponent = -1;%常数2为指数值，改为0即不使用科学计数法
    xlabel('time [s]');
    ylabel('curvature');
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
end