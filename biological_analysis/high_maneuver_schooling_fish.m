%%
% high_maneuverability_example includes the empirical data in Figure1d-f  [pos_x, pos_y, vel_x, vel_y, 
% C_ij matrix, LF-based interaction network, temporal group curvature, polarization, LF-based interaction matrix]
% This MATLAB code is designed to process and visualize empirical data associated with high maneuverability systems. 
% It involves plotting various data related to positions, velocities, interaction matrices, curvature, and polarization in a multi-figure layout. 
% The data includes elements like bipartite graphs and nestedness detection, which are analyzed and visualized through multiple plots.
%%
clear;
clc;
addpath("../data/")
addpath("../utility/")
load("high_maneuverability.mat")
cyctime = 0.01;
max_G = high_maneuverability_example{1, 6};
pos_x = high_maneuverability_example{1, 1};
pos_y = high_maneuverability_example{1, 2};
%
figure
figSize_L = 4;
figSize_W = 4;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
C_ij = high_maneuverability_example{1, 10};
plot_format = PlotFormat();
plot_format.use_labels = true;
plot_format.back_color = [0.6000,0.7686,1.0000];
plot_format.cell_color = 'white';
font_size = 20;
mat_plot = PlotWebs.PLOT_NESTED_MATRIX(C_ij, plot_format);
%  
%
figure
figSize_L = 4;
figSize_W = 4;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
for p = 1:15
    Color = turbo(length(pos_x(:,p)));
    cf = [uint8(Color*255) uint8(ones(size(Color,1),1))]'; 
    patch([pos_x(:,p)' NaN], [pos_y(:,p)' NaN], [[1:length(pos_x(:,p))]/(length(pos_x(:,p))-1)  NaN], ...
                                'EdgeColor','flat','MarkerFaceColor','flat','LineWidth',0.5)
    hold on
    colormap(turbo)
end
box on
hold on
tank_radius = 35; % 
rectangle('Position',[1280 * (0.078326)/2 - tank_radius, 1024 * (0.078326)/2 - tank_radius, tank_radius*2, tank_radius*2], 'Curvature',[1 1])
axis equal
xlabel("x (cm)")
ylabel("y (cm)")
axis equal
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
% 
figure
figSize_L = 5.5;
figSize_W = 4;
set(gcf,'Units','centimeter','Position',[5 5 figSize_L figSize_W]);
curvature_time = high_maneuverability_example{1, 7};
op_time = high_maneuverability_example{1, 9};
plot([1:length(pos_x(:,1))].*cyctime, curvature_time,'lineWidth', 1.5)
xlim([0, length(pos_x(:,1)).*cyctime])
hold on
a = area([1:length(pos_x(:,1))].*cyctime, curvature_time);
a.FaceColor = [222,235,247]./255;
% alpha(0.5)
xlabel("time (s)")
ylabel("curvature")
hold on
yyaxis right
plot([1:length(pos_x(:,1))].*cyctime, op_time,'lineWidth', 1.5)
ylabel("polarization")
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
set(gca, 'Fontname', 'helvetica', 'FontSize', 9)
