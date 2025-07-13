% This MATLAB code is used to visualize the robot trajectories during a following task under two different network models: 
% PNIN (Potential Network Inference Network) and WSIN (Wavefront Sensing Inference Network). 
% The code uses two separate data files, Following_PNIN.mat and Following_WSIN.mat, to visualize how robots behave under these two models.
clear;clc
addpath("../utility/")
load("../data/robotic_experiments_data/Following_PNIN.mat")
drawRobotsTraj_following(G)
drawRobotsTraj_followingInfo(G)
%%
clear;clc
addpath("../utility/")
load("../data/robotic_experiments_data/Following_WSIN.mat")
drawRobotsTraj_following(G)
drawRobotsTraj_followingInfo(G)
