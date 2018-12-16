% 2016-2017, created by JN Kather, includes code snippets by Jan Poleszczuk
%
% Figure 3: Stroma slows tumor growth in a lymphocyte-deprived, but 
% mediates immune escape in a lymphocyte enriched environment. (A) 
% experimental design, (B) tumor mass over time for all four groups, 
% depending on probability of stroma generation (Stro low vs. high) and 
% the magnitude of immune cell influx (Lym low vs. high) (C) outcome 
% three months after baseline (60 days, dashed line). Response criteria 
% were chosen analogous to the RECIST criteria. The subgroup ?Stro 
% low, Lym high? had a 100% response rate, the majority complete responses 
% (i.e. eradication of all tumor cells). Abbreviaions: PD = progressive 
% disease, SD = stable disease, PR = partial remission, CR = complete 
% remission.
% cd 'C:\Users\s167917\Documents\#School\Jaar 3\2 OGO Computational Biology\BEP_model'
%% PREPARE
close all, clear all, format compact, clc
addpath('./subroutines_2D/'); % include all functions for the 2D model
addpath('./subroutines_ND/'); % include generic subroutines

for expname =  ...
		{'ll','hl','lh','hh'}

    
randmodulator = 100; % default 100, for duplicate: 101, for triplicate: 102
[modVars1,modVars2,override,tFirstRun,domSize,tAfterInterv1,tAfterInterv2] = ...
    getHyperparametersImmunotherapy_new(expname); % get hyperparameters for current experiment
[systemTemplate, cnst] = getSystemParams('2D',domSize); % create system template
cnst.nSteps = tFirstRun(1);
cnst.drawWhen = tFirstRun(2);
requireTumorAlive = tFirstRun(1); % require tumor to be alive for at least ... 
                              % iterations to exclude random effects
disp(['###',10,'starting experiment ',char(expname),10]);

% OVERRIDE PROPERTIES
if ~isempty(fieldnames(override))
    disp('trying to override static variables BEFORE...');
    cellfun(@(f) evalin('caller',...
    ['systemTemplate.params.' f ' = override.' f ';']), fieldnames(override));
end
    
cnst.saveImage = true; % save image after each run
sysPackOne = getSystemPackage(modVars1,systemTemplate,randmodulator);





disp('updated parameter container for FIRST RUN');
disp(['will perform ',num2str(numel(sysPackOne)),' runs']);

% PREPARE THE SYSTEM
rng('shuffle');
masterID = ['TvI_',dec2hex(round(rand()*10e10)),'_',char(expname)];
mkdir(['./output/',masterID]);
disp('starting the model...');

%% FIRST RUN: GROW TUMOR
globalTime = tic;
%parfor
% DEBUG DEBUG
parfor i=1:numel(sysPackOne) % FIRST RUN: RUN SYSTEM UNTIL INTERIM ANALYSIS
    disp([10,'starting first run of experiment #',num2str(i)]);
    % START PLAUSIBILITY CHECK ----------------------------------------------
    if ~checkPlausibility(sysPackOne{i})
        warning('implausible parameter set'); continue
    end
    % END PLAUSIBILITY CHECK ------------------------------------------------
    nAttempts = 1;
    while nAttempts <= 5 % try 5 times 
        partialTime = tic;
        disp('starting analysis...'); % run the model
        [sysPackOne{i}, lastImage, summaryOne{i}, imWin, fcount] = ...
            growTumor_2D(sysPackOne{i},cnst);
        disp(['finished experiment #',num2str(i), ', nAttempts = ', num2str(nAttempts),...
            ', time needed: ', num2str(toc(partialTime)), ' imWin = ', num2str(imWin)]);
        % if the tumor was eradicated prematurely, try a different seed
        if imWin~=0 && imWin <= requireTumorAlive 
            sysPackOne{i}.params.initialSeed = sysPackOne{i}.params.initialSeed + 10;
            nAttempts = nAttempts + 1;
            disp('attempt was NOT successful');
        else % successful -> save images
            if cnst.saveImage
                for k = 1:fcount
                imwrite(lastImage{k},['./output/',masterID,'/','iter_',num2str(i),...
                    '_01-ONE_frame_',num2str(k),'_attempt_',num2str(nAttempts),'.png']);
                disp(['saved experiment #',num2str(i),' frame ', num2str(k), ' PRE']);
                end
            end
            disp(['attempt was successful',10]); break
        end
    end
end
disp(['total time was ',num2str(toc(globalTime))]);
if cnst.doSummary % summarize first experiment
    [finalSummaryOne,paramsOne] = summarizeExperiment_2D(sysPackOne,cnst);
end

%% SECOND RUN: DIFFERENTIATE TUMORS
disp([10,'###',10,'starting second run',10]);
% create parameter sets for SECOND RUN
sysPackTwo = modifyTwoParams(sysPackOne,modVars1); % second package = after differentiation
disp('updated parameter container for SECOND RUN');
cnst_second = cnst; % prepare parameters for additional steps
cnst_second.nSteps = tAfterInterv1; % additional steps
cnst_second.createNewSystem = false; % use existing simulation
saveImage = cnst.saveImage; 

%parfor
parfor i=1:numel(sysPackTwo) % SECOND RUN
disp(['starting second run of experiment #',num2str(i)]);
    % SECOND PART: RUN SYSTEM AGAIN
    [sysPackTwo{i}, lastImage, summaryTwo{i}, imWin, fcount] = ...
        growTumor_2D(sysPackTwo{i},cnst_second);
        if saveImage
            for k = 1:fcount
            imwrite(lastImage{k},['./output/',masterID,'/','iter_',num2str(i),...
                '_02-TWO_frame_',num2str(k),'.png']);
            disp(['saved experiment #',num2str(i),' frame ', num2str(k), ' POST']);
            end
        end   
    disp(['finished second run of experiment #',num2str(i)]); 
end

if cnst.doSummary % summarize second experiment
    [finalSummaryTwo,paramsTwo] = summarizeExperiment_2D(sysPackTwo,cnst_second);  
end

%% THIRD RUN: AFTER INTERVENTION IMMUNOTHERAPY
disp([10,'###',10,'starting third run',10]);
% create parameter sets for THIRD RUN
sysPackThree = modifyTwoParams(sysPackTwo,modVars2); % third package = after intervention
disp('updated parameter container for THIRD RUN');
cnst_third = cnst; % prepare parameters for additional steps
cnst_third.nSteps = tAfterInterv2; % additional steps
cnst_third.createNewSystem = false; % use existing simulation
saveImage = cnst.saveImage; 

%parfor
parfor i=1:numel(sysPackThree) % SECOND RUN
disp(['starting second run of experiment #',num2str(i)]);
    % SECOND PART: RUN SYSTEM AGAIN
    [sysPackThree{i}, lastImage, summaryThree{i}, imWin, fcount] = ...
        growTumor_2D(sysPackThree{i},cnst_third);
        if saveImage
            for k = 1:fcount
            imwrite(lastImage{k},['./output/',masterID,'/','iter_',num2str(i),...
                '_03-THREE_frame_',num2str(k),'.png']);
            disp(['saved experiment #',num2str(i),' frame ', num2str(k), ' POST']);
            end
        end   
    disp(['finished second run of experiment #',num2str(i)]); 
end

if cnst.doSummary % summarize third experiment
    [finalSummaryThree,paramsThree] = summarizeExperiment_2D(sysPackThree,cnst_third);  
end

% SAVE ALL RESULTS
save(['./output/',masterID],'finalSummaryOne','paramsOne',...
    'finalSummaryTwo','paramsTwo','finalSummaryThree','paramsThree',...
    'summaryOne','summaryTwo','summaryThree');

% clean up
clear set finalSummaryOne paramsOne finalSummaryTwo paramsTwo finalSummaryThree paramsThree
clear summaryOne summaryTwo summaryThree cnst_second cnst_third sysPackOne sysPackTwo sysPackThree


end

