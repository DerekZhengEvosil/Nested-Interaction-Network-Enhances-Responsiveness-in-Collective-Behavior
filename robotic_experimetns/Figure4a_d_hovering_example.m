%% WSIN hovering basic info
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