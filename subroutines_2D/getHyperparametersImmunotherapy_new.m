function [modVars1,modVars2,overrideBefore,timeFirstRun,domainSize,addSteps1,addSteps2] = getHyperparametersImmunotherapy_new(expname)

% default time and space parameters
timeFirstRun = [120 30];
domainSize = [400 400];
addSteps1 = 240;
addSteps2 = 120;
overrideBefore = struct();

nr = 1;
switch char(expname) % parameters change after intervention
    case 'hh'
    modVars1.TUpblock_change = repmat(10,[1 nr]);
    modVars1.IM1inflRate = repmat(7,[1 nr]);
    
    modVars2.TUpblock_change = repmat(1,[1 nr]);
    modVars2.IM1inflRate = repmat(7,[1 nr]);
    
    case 'hl'
    modVars1.TUpblock_change = repmat(10,[1 nr]);
    modVars1.IM1inflRate = repmat(1,[1 nr]);
    
    modVars2.TUpblock_change = repmat(1,[1 nr]);
    modVars2.IM1inflRate = repmat(1,[1 nr]); 
    
    case 'lh'
    modVars1.TUpblock_change = repmat(1,[1 nr]);
    modVars1.IM1inflRate = repmat(7,[1 nr]);
    
    modVars2.TUpblock_change = repmat(0.1,[1 nr]);
    modVars2.IM1inflRate = repmat(7,[1 nr]); 
    
    case 'll'
    modVars1.TUpblock_change = repmat(1,[1 nr]);
    modVars1.IM1inflRate = repmat(1,[1 nr]);
    
    modVars2.TUpblock_change = repmat(0.1,[1 nr]);
    modVars2.IM1inflRate = repmat(1,[1 nr]); 
    
end
end