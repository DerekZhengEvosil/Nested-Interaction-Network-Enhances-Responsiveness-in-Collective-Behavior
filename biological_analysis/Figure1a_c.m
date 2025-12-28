clear;clc;
addpath("../data/biological_data/")
load("NODF_curvature_polarization")
%% 
% M_index represents average group curvature
% op is the average group polarization
% NODF is the nestedness of each interaction network in fish schools
%% figure 1a
figure
figSize_L = 10;
figSize_W = 10;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
g = gramm('x',draw_op,'y',draw_M_index,'color',draw_op);
g.set_names('x','average group polarization','y','average group curvature');
g.geom_point(); %Scatter plot
g.stat_glm();
g.set_point_options('base_size',3);
g.set_layout_options('position',[0.1 0.05 0.8 0.8],...
    'legend_pos',[0.83 0.75 0.2 0.2],... %We detach the legend from the plot and move it to the top right
    'margin_height',[0.1 0.02],...
    'margin_width',[0.1 0.02],...
    'redraw',false);
g.set_continuous_color('LCH_colormap',[20 80 ; 40 30 ; 260 260 ]);
g.axe_property('box','on','XLim', [0.5,1]); 
g.set_color_options('map','d3_10');
g.draw();
%% figure 1c
figure
figSize_L = 10;
figSize_W = 3.5;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
g = gramm('x',draw_op,'y',draw_U_turn_NODF,'color', color_ind);
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
%% figure 1b
figure
figSize_L = 10;
figSize_W = 3.5;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
g = gramm('x',draw_M_index,'y',draw_U_turn_NODF,'color', color_ind);
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
