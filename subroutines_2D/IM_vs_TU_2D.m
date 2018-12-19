% JN Kather 2016
% this function can be compiled to yield a massive speed increase
function [TUcells, TUprop, IM1cells, IM1prop, L, Lt] = ...
IM_vs_TU_2D(TUcells, TUprop, IM1cells, IM1prop, L, Lt,IMpkill,nh,ChtaxMap,engagementDuration,IM1pprol_low,IM1pdeath_high)

% pre-select immune cells that may be close enough to the tumor
candidates = ChtaxMap(IM1cells)<=1;
if sum(candidates(:)) % if there are candidates
    % select cells that are going to kill
    killers = candidates & (IM1prop.engaged==0) & (IM1prop.Kcap>0) & (rand(1,length(IM1cells))<IMpkill);
    acting_killer = find(killers); % cell indices
    nr_killers = length(acting_killer);
    if nr_killers>0 % if there is a cell that is going to kill
        % preallocate
        targetIDs = int32(zeros(1,nr_killers)); 
        killerIDs = int32(zeros(1,nr_killers));
        blockedIDs = int32(zeros(1,nr_killers));        
        
        % start tumor cell killing, same random order as before
        St = bsxfun(@plus,IM1cells(acting_killer),nh.aux(nh.Pms(:,randi(nh.nP,1,nr_killers))));
        % iterate through all immune cells and look at their neighborhood
        for jj = 1:nr_killers
            neighbPosit = St(randperm(length(nh.aux)),jj);
            instakill = ismember(neighbPosit(:),TUcells(:));
            % if the cell encounters another cell to kill
            if sum(instakill) > 0
                % if more than 1 possible targets then use the first one
                possibleTargets = neighbPosit(instakill); % possible targets
                target = int32(possibleTargets(1)); % kill only the first candidate               
                
                if rand() <= TUprop.pblock(TUcells==target) %if blocked
                    blockedIDs(jj) = IM1cells(acting_killer(jj)); % add blocked ID
                else
                    targetIDs(jj) = target; % add target ID to stack
                    killerIDs(jj) = IM1cells(acting_killer(jj)); % add killer ID to stack                    
                end
            end
        end
        
        % remove zeros
        blockedIDs = nonzeros(blockedIDs);
        targetIDs = nonzeros(targetIDs);
        killerIDs = nonzeros(killerIDs);
        
        % find indices to killed cell and killer cell. If the unlikely case
        % happens that one tumor cell is simultaneously killed by two immune cells,
        % then both will be exhausted. In the unlikely case that one tumor
        % cell blocks multiple attacks simultaneously, the pblock of the
        % tumor will only change once
        
        if targetIDs % if killing happens, then update            
            auxKillTU = ismember(TUcells,targetIDs); % which tumor cells are killed
            auxKillIM = ismember(IM1cells,killerIDs); % which immmune cells do kill
            L(TUcells(auxKillTU)) = false;  % FIRST remove from L grid
            Lt(TUcells(auxKillTU)) = false;  % ... and remove from Lt grid
            [TUcells,TUprop] = removeTU(TUcells,TUprop,auxKillTU); % second, remove from stack
            IM1prop.Kcap(auxKillIM) = IM1prop.Kcap(auxKillIM)-1; % exhaust killers
            IM1prop.engaged(auxKillIM) = engagementDuration; % killers are engaged
        end
        if blockedIDs % if blocking happens, then update            
            blockedIM = ismember(IM1cells,blockedIDs); % which immune cells' attack was blocked
            IM1prop.pdeath(blockedIM) = IM1pdeath_high; % change probablity apoptosis immune cells
            IM1prop.pprol(blockedIM) = IM1pprol_low; % change probability proliferation immune cells
            
        end
    end % end actual killing filter
end % end candidate filter
end % end function
