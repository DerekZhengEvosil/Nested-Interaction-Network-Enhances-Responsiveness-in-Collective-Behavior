% This MATLAB code generates a horizontal violin plot to visualize and compare various metrics related to the collective following task
clear;clc;
addpath("../utility/")
load("../data/robotic_experiments_data/collecitve_following_metrics.mat")
figure
figSize_L = 16;
figSize_W = 10;
set(gcf, 'Units', 'centimeter','Position', [5 5 figSize_L figSize_W])
used_num = 30;
% 
dataCell={X1,X2,X3,X4}; 
dataName={'WSIN-response accuracy','PNIN-response accuracy','WSIN-responsiveness','PNIN-responsiveness'};
colorList=[253,191,111
255,127,0
202,178,214
106,61,154]./255;      
% =========================================================================
classNum=length(dataCell);
if size(colorList,1)==0
    colorList=repmat([130,170,172]./255,[classNum,1]);
else
    colorList=repmat(colorList,[ceil(classNum/size(colorList,1)),1]);
end
if isempty(dataName)
    for i=1:classNum
        dataName{i}=['class',num2str(i)];
    end
end
hold on
ax=gca;
ax.YLim=[1/2,classNum+4/3];
ax.YTick=1:classNum;
% ax.LineWidth=0;
ax.YTickLabels=dataName(end:-1:1);
ax.FontSize=14;
rate=0.02;

for i=1:classNum
    tX=dataCell{i};tX=tX(:);
    [F,Xi]=ksdensity(tX);
    patchCell(i)=fill([Xi(1),Xi,Xi(end)],0.2+[0,F,0].*rate+(classNum+1-i).*ones(1,length(F)+2),...
        colorList(i,:),'EdgeColor',[0,0,0],'FaceAlpha',0.8,'LineWidth',0.1);
    qt25=quantile(tX,0.25);
    qt75=quantile(tX,0.75); 
    med=median(tX);         

    outliBool=isoutlier(tX,'quartiles');  
    nX=tX(~outliBool);                   
    tY=(rand(length(tX),1)-0.5).*0.24+ones(length(tX),1).*(classNum+1-i);
    scatter(tX,tY,10,'CData',colorList(i,:),'MarkerEdgeAlpha',0.3,...
        'MarkerFaceColor',colorList(i,:),'MarkerFaceAlpha',0.3)
    plot([min(nX),max(nX)],[(classNum+1-i),(classNum+1-i)],'k','lineWidth',0.2);
    fill([qt25,qt25,qt75,qt75],(classNum+1-i)+[-1 1 1 -1].*0.1,colorList(i,:),'EdgeColor',[0 0 0]);
    plot([med,med],[(classNum+1-i)-0.1,(classNum+1-i)+0.1],'Color',[0,0,0],'LineWidth',0.1)

end
lgd=legend(patchCell,dataName,'box','off');
lgd.Location='best';
set(gca,'YTickLabel',[])
box on
xlabel("response accuracy/responsivenss")
set(gca, 'Fontname', 'helvetica', 'FontSize', 12)
