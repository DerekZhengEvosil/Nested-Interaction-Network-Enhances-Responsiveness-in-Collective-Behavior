%% WSIN hovering basic info
% This code involves two main tasks: loading data related to WSIN (Wavefront Sensing Inference Network) and PNIN (Potential Network Inference Network), 
% then drawing and visualizing the robot trajectories during a collective hovering task in these two swarm models.
clear;clc
addpath("../utility/")
dataFile = "../data/robotic_experiments_data/Hovering_WSIN.mat";
load(dataFile)
ck = drawRobotsTraj_hovering_info(G);
%% PNIN hovering basic info
clear;clc
dataFile = "../data/robotic_experiments_data/Hovering_PNIN.mat";
addpath("../utility/")
load(dataFile)
ck = drawRobotsTraj_hovering_info(G);
