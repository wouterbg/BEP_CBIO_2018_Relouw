% 2016-2017, created by JN Kather, includes code snippets by Jan Poleszczuk
% license: see separate license file

% What is this? this is an agent-based model of tumor cell - immune cells interactions
% How does it work? open this file in Matlab and run it.

close all, clear all, format compact,  clc
% cd 'C:\Users\s167917\Documents\#School\Jaar 3\2 OGO Computational Biology\BEP_model'
addpath('./subroutines_2D/'); % include all functions for the 2D model
addpath('./subroutines_ND/'); % include generic subroutines

% all parameters for the model are stored in the structure "sysTempl".
% Hyperparameters are stored in the structure "cnst". If you want to 
% manually change parameters, you need to overwrite the respective value 
% in sysTempl.params or in cnst, for example by adding
% "sysTempl.params.TUps = 0.65" after the call to "getSystemParams"
[sysTempl, cnst] = getSystemParams('2D',[320 320]);

% override some system parameters (just for this example)
sysTempl.params.TUpblock_start = 0;
sysTempl.params.TUpblock_change = 1;

change = 0.0;
sysTempl.params.IM1pprol_low = 0.0449-change;
sysTempl.params.IM1pdeath_high = 1-(1-0.0037)^4+change;

saveImage = true;
saveVideo = true;

% add/override some global variables after loading the system
cnst.nSteps   = 80;    % how many iterations in the first place
cnst.drawWhen = 1;      % draw after ... iterations
expname = 'demoVideo';    % experiment name that will be used to save results

[sysOut, lastFrame, summary, imWin, fcount, masterID] = ...
    runSystem(sysTempl,cnst,expname,saveImage,saveVideo); % run the system
