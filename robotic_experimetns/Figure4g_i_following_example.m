% This MATLAB code is used to visualize the robot trajectories during a following task under two different network models
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
