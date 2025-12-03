function [heading, respondness, rotRate] = drawRobotsTraj_followingInfo(G)
    if isfield(G,'infoIDs')
        infoID = G.infoIDs;
    else
        infoID = [1];
    end
    dt = G.cycTime;
    heading = nan * zeros(G.simStep,G.maxID);
    speed = nan * zeros(G.simStep,G.maxID);
    rotRate = nan * zeros(G.simStep,G.maxID);
    flockpos = nan * zeros(G.simStep,2);
    respondness = nan * zeros(G.simStep,1);
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
        flockpos(t,:) = nanmean(posDir(:,[1,2]),1);
    end
    % traj of the informed individual
    load("sky_color.mat")
    figure
    figSize_L = 4.5;
    figSize_W = 6;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    tailTraj = G.actor{infoID}.memory(:,[1,2]);
    color_proj = [1:length(tailTraj(:,2))]/(length(tailTraj(:,2)));
%     line(tailTraj(:,1),tailTraj(:,2),'linestyle','-','linewidth',1,'color',[0,0,0]); 
    patch([tailTraj(:,1)' NaN], [tailTraj(:,2)' NaN], [color_proj NaN], ...
                                    'EdgeColor','flat','MarkerFaceColor','flat','LineWidth',1,'FaceAlpha', 1,'EdgeAlpha',1)
    hold on;
    colormap(sky)
%     colormap(turbo)
%     h = colorbar('FontSize',9,'Location','northoutside');
%     t = get(h,'YTickLabel');
%     t = strcat(t,'s');
%     set(h,'YTickLabel',t);
%     set(h,'Ticks',[1:5]')
%     set(h, 'TickLabels', num2cell(dt.*round(linspace(1, G.simStep, 5))))
%     set(h,'TicksMode','auto')
    % turn 1
    line(tailTraj(20:80,1),tailTraj(20:80,2),'linestyle','-','linewidth',1,'color',[238,0,9]./255); 
    % turn 2
    line(tailTraj(200:300,1),tailTraj(200:300,2),'linestyle','-','linewidth',1,'color',[238,0,9]./255); 
    % turn 3
    line(tailTraj(320:375,1),tailTraj(320:375,2),'linestyle','-','linewidth',1,'color',[238,0,9]./255); 
    % turn 4
    line(tailTraj(420:475,1),tailTraj(420:475,2),'linestyle','-','linewidth',1,'color',[238,0,9]./255); 
    box on;
    axis equal
    xlabel("x [mm]")
    ylabel("y [mm]")
    set(gca,'XTickLabel',[])
    set(gca,'YTickLabel',[])
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)

    figure
    figSize_L = 3.5;
    figSize_W = 2.5;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    plot([1:G.simStep].*dt, heading(:,infoID),'linewidth',0.5,'color',[0,0,0]./255); 
    hold on;
    plot([20:80].*dt, heading(20:80,infoID),'linewidth',0.5,'color',[238,0,9]./255); 
    hold on
    plot([200:300].*dt, heading(200:300,infoID),'linewidth',0.5,'color',[238,0,9]./255); 
    hold on
    plot([320:375].*dt, heading(320:375,infoID),'linewidth',0.5,'color',[238,0,9]./255); 
    hold on
    plot([420:475].*dt, heading(420:475,infoID),'linewidth',0.5,'color',[238,0,9]./255); 
    xlabel('time [s]');
    ylabel('heading (deg)');
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)

    figure
    figSize_L = 7;
    figSize_W = 2.5;
    set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
    plot([1:G.simStep].*dt, heading,'linewidth',0.5); hold on;
    plot([1:G.simStep].*dt, heading(:,infoID),'linewidth',1,'color',[0,0,0]./255); 
    hold on;
    xlabel('time [s]');
    ylabel('heading (deg)');
    set(gca, 'Fontname', 'helvetica', 'FontSize', 9)

end