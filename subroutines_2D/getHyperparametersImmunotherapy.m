function [modVars1,modVars2,overrideBefore,timeFirstRun,domainSize,addSteps1,addSteps2] = getHyperparametersImmunotherapy(expname)

% nI = sample the parameter space in how many levels per dimension, default 10
% caution: if you change nI, do so before assigning other parameters

% default time and space parameters
timeFirstRun = [50 50];
domainSize = [600 600];
addSteps1 = 500; 
nI = 8;
overrideBefore = struct();
    
switch char(expname) % parameters change after intervention
    
    case 'test'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 2]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(2,[1 2]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 2]);
    modVars2.IM1inflRate = repmat(2,[1 2]);
    
    case 'INTERVENTION_2_IM1_0_25_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(2,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(2,[1 5]);
    
    case 'INTERVENTION_2_IM1_0_50_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.50,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(2,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(2,[1 5]);
    
    case 'INTERVENTION_2_IM1_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(2,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(2,[1 5]);
    
    case 'INTERVENTION_3_IM1_0_25_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(3,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(3,[1 5]);
    
    case 'INTERVENTION_3_IM1_0_50_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.50,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(3,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(3,[1 5]);
    
    case 'INTERVENTION_3_IM1_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(3,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(3,[1 5]);
    
    case 'INTERVENTION_4_IM1_0_25_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(4,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(4,[1 5]);    

    case 'INTERVENTION_4_IM1_0_50_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.50,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(4,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(4,[1 5]); 
    
    case 'INTERVENTION_4_IM1_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(4,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(4,[1 5]); 
    
    case 'INTERVENTION_5_IM1_0_25_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(5,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(5,[1 5]);    

    case 'INTERVENTION_5_IM1_0_50_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.50,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(5,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(5,[1 5]); 
    
    case 'INTERVENTION_5_IM1_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(5,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(5,[1 5]);     

    case 'INTERVENTION_7_IM1_0_25_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.25,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(7,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(7,[1 5]);    

    case 'INTERVENTION_7_IM1_0_50_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.50,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(7,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(7,[1 5]); 
    
    case 'INTERVENTION_7_IM1_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);       %was repmat(0.06,[1 5]); 
    modVars1.IM1inflRate = repmat(7,[1 5]);   %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IM1inflRate = repmat(7,[1 5]);   
    
    case 'INTERVENTION_7_IM1_IM2_0_75_TUpblock'
    domainSize = [400 400]; % was 500 500
    timeFirstRun = [120 15]; % was 120 30
    addSteps1 = 240;         % was 360
    addSteps2 = 120;
    
    modVars1.TUpblock = repmat(0.75,[1 5]);         %was repmat(0.06,[1 5]); 
    modVars1.IMinflRate = repmat(7,[1 5]);          %was repmat(8,[1 10]);  
    
    modVars2.effImmuno = repmat(0.75,[1 5]);
    modVars2.IMinflRate = repmat(7,[1 5]); 
    
end
end