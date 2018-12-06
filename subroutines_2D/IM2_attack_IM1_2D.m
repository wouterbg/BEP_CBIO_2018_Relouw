% [added]
% this function can be compiled to yield a massive speed increase
function [IM1cells, IM1prop, IM2cells, IM2prop, L, Lt] = ...
IM2_attack_IM1_2D(IM1cells, IM1prop, IM2cells, IM2prop, L, Lt,IMpkill,nh,ChtaxMap,engagementDuration)

% pre-select immune cells that may be close enough to the tumor
candidates = ChtaxMap(IM2cells)<=1;
if sum(candidates(:)) % if there are candidates
    % select cells that are going to attack
    K = candidates & (IM2prop.engaged==0) & (IM2prop.Kcap>0) & (rand(1,length(IM2cells))<IMpkill);
    actK = find(K); % cell indices
    if ~isempty(actK) % if there is a cell that is going to attack
    targetIDs = int32(zeros(1,0)); % preallocate
    attackersIDs = int32(zeros(1,0)); % preallocate
    % start tumor cell attacking, same random order as before
    St = bsxfun(@plus,IM2cells(actK),nh.aux(nh.Pms(:,randi(nh.nP,1,length(actK)))));
    % iterate through all immune cells and look at their neighborhood
    for jj = 1:size(St,2) 
        neighbPosit = St(randperm(length(nh.aux)),jj);
        instaattack = ismember(neighbPosit(:),IM1cells(:));
        % if the cell encounters another cell to attack
        if sum(instaattack) > 0 
            % if more than 1 possible targets then use the first one
            possibleTargets = neighbPosit(instaattack); % possible targets
            attackwhat = int32(possibleTargets(1)); % attack only the first candidate   
            targetIDs = [targetIDs, attackwhat]; % add target ID to stack
            attackersIDs = [attackersIDs, IM2cells(actK(jj))]; % add attacker ID to stack
        end
    end
    
    % find indices to attacked cell and attacker cell. If the unlikely case
    % happens that one tumor cell is simultaneously attacked by two immune cells,
    % then both will be exhausted
    auxattackIM1 = ismember(IM1cells,targetIDs); % which immune 1 cells are exhausted
    auxattackIM2 = ismember(IM2cells,attackersIDs); % which immune 2 cells do exhaust

    if sum(auxattackIM1)>0                  % if attacking happens, then update  
        IM1prop.Kcap(auxattackIM1) = IM1prop.Kcap(auxattackIM1)-1; % exhaust attacked cells
        IM2prop.Kcap(auxattackIM2) = IM2prop.Kcap(auxattackIM2)-1; % exhaust attackers
        IM2prop.engaged(auxattackIM2) = engagementDuration; % attackers are engaged
    end

    end % end actual attacking filter
end % end candidate filter
end % end function
