clear;clc;
addpath("../data/")
load("NODF_curvature_polarization")
% This MATLAB code aims to analyze and visualize the relationship between various factors affecting fish schools, 
% specifically their group curvature, polarization, and nestedness (a measure of network interaction). 
% The code generates several figures (1a, 1b, and 1c) displaying different statistical relationships, including correlation plots and scatter plots.
%% 
% color_ind categorize the group size of fish data, 
% 1-5 fish, 2-10 fish, 3-15 fish
% M_index represents average group curvature
% op is the average group polarization
% NODF is the nestedness of each interaction network in fish schools
%% figure 1a
figure
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
g(1,1)=gramm('x',(op));
g(1,1).set_layout_options('Position',[0.1 0.8 0.62 0.2],... %Set the position in the figure (as in standard 'Position' axe property)
    'legend',false,... % No need to display legend for side histograms
    'margin_height',[0.02 0.05],... %We set custom margins, values must be coordinated between the different elements so that alignment is maintained
    'margin_width',[0.1 0.02],...
    'redraw',false); %We deactivate automatic redrawing/resizing so that the axes stay aligned according to the margin options
g(1,1).set_names('x','');
g(1,1).stat_bin('geom','stacked_bar','fill','transparent','normalization','probability'); %histogram
g(1,1).axe_property('XTickLabel',''); % We deactivate tht ticks
%Create a scatter plot
g(2,1)=gramm('x',op,'y',M_index,'color',op);
g(2,1).set_names('x','average group polarization','y','average group curvature');
g(2,1).geom_point(); %Scatter plot
g(2,1).stat_glm();
g(2,1).set_point_options('base_size',3);
g(2,1).set_layout_options('position',[0.1 0.05 0.62 0.7],...
    'legend_pos',[0.83 0.75 0.2 0.2],... %We detach the legend from the plot and move it to the top right
    'margin_height',[0.1 0.02],...
    'margin_width',[0.1 0.02],...
    'redraw',false);
g(2,1).set_continuous_color('LCH_colormap',[20 80 ; 40 30 ; 260 260 ]);
g(2,1).axe_property('box','on','XLim', [0.5,1]); 
%Create y data histogram on the right
g(3,1)=gramm('x',M_index);
g(3,1).set_layout_options('Position',[0.75 0.05 0.2 0.7],...
    'legend',false,...
    'margin_height',[0.1 0.02],...
    'margin_width',[0.02 0.05],...
    'redraw',false);
g(3,1).set_names('x','');
g(3,1).stat_bin('geom','stacked_bar','fill','transparent','normalization','probability'); %histogram
g(3,1).coord_flip();
g(3,1).axe_property('XTickLabel','');
g.set_color_options('map','d3_10');
g.draw();
%% figure 1b
figure
figSize_L = 10;
figSize_W = 3.5;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
% [b,~,~,~,stats] = regress(used_U_turn_NODF',used_op');
%Create a scatter plot
g = gramm('x',op,'y',NODF,'color', color_ind);
g.set_names('x','average group polarization','y','Nestedness');
g.geom_point('alpha',0.7); %Scatter plot
g.set_point_options('base_size',3);
g.axe_property('box','on','XLim', [0.5,1]); 
g.set_color_options('map','matlab');
g.draw();
g.update('color',[])
g.stat_glm();
g.set_color_options('map','brewer3');
g.draw();
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
%% figure 1c
figure
figSize_L = 10;
figSize_W = 3.5;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
%Create a scatter plot
g = gramm('x',M_index,'y',NODF,'color', color_ind);
g.set_names('x','average group curvature','y','Nestedness');
g.geom_point('alpha',0.7); %Scatter plot
g.set_point_options('base_size',3);
g.axe_property('box','on'); 
g.set_color_options('map','matlab');
g.draw();
% g.set_continuous_color('LCH_colormap',[20 80 ; 40 30 ; 260 260 ]);
g.update('color',[])
g.stat_glm();
g.set_color_options('map','brewer3');
g.draw();
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
