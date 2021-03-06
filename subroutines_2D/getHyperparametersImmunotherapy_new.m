function [modVars1,modVars2,overrideBefore,timeFirstRun,domainSize,addSteps1,addSteps2] = getHyperparametersImmunotherapy_new(expname)

% default time and space parameters
timeFirstRun = [120 30];
domainSize = [400 400];
addSteps1 = 240;
addSteps2 = 120;
overrideBefore = struct();
nr = 5;

switch char(expname) % parameters change after intervention
    case '0.25_7'
    modVars1.TUpblock_start = repmat(0.25,[1 nr]);
    modVars1.IM1inflRate = repmat(7,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(7,[1 nr]);
    
    case '0.25_5'
    modVars1.TUpblock_start = repmat(0.25,[1 nr]);
    modVars1.IM1inflRate = repmat(5,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(5,[1 nr]); 
    
    case '0.25_3'
    modVars1.TUpblock_start = repmat(0.25,[1 nr]);
    modVars1.IM1inflRate = repmat(3,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(3,[1 nr]); 
    
    case '0.5_7'
    modVars1.TUpblock_start = repmat(0.5,[1 nr]);
    modVars1.IM1inflRate = repmat(7,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(7,[1 nr]);
    
    case '0.5_5'
    modVars1.TUpblock_start = repmat(0.5,[1 nr]);
    modVars1.IM1inflRate = repmat(5,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(5,[1 nr]); 
    
    case '0.5_3'
    modVars1.TUpblock_start = repmat(0.5,[1 nr]);
    modVars1.IM1inflRate = repmat(3,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(3,[1 nr]); 
    
    case '0.75_7'
    modVars1.TUpblock_start = repmat(0.75,[1 nr]);
    modVars1.IM1inflRate = repmat(7,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(7,[1 nr]); 
    
    case '0.75_5'
    modVars1.TUpblock_start = repmat(0.75,[1 nr]);
    modVars1.IM1inflRate = repmat(5,[1 nr]);
    
    modVars2.TUpblock_change = repmat(0.1,[1 nr]);
    modVars2.IM1inflRate = repmat(5,[1 nr]); 
    
    case '0.75_3'
    modVars1.TUpblock_start = repmat(0.75,[1 nr]);
    modVars1.IM1inflRate = repmat(3,[1 nr]);
    
    modVars2.effImmuno = repmat(0.75,[1 nr]);
    modVars2.IM1inflRate = repmat(3,[1 nr]); 
    
end
end