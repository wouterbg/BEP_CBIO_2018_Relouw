% JN Kather 2016
% this function can be compiled to yield a massive speed increase
function [TUcells, TUprop, IMcells, IMprop, L, Lt] = ...
IM_vs_TU_2D(TUcells, TUprop, IMcells, IMprop, L, Lt,IMpkill,nh,ChtaxMap,engagementDuration,new_pprol,new_pdeath,pblock_change)

% pre-select immune cells that may be close enough to the tumor
candidates = ChtaxMap(IMcells)<=1;
if sum(candidates(:)) % if there are candidates
    % select cells that are going to kill
    killers = candidates & (IMprop.engaged==0) & (IMprop.Kcap>0) & (rand(1,length(IMcells))<IMpkill);
    acting_killer = find(killers); % cell indices
    nr_killers = length(acting_killer);
    if nr_killers>0 % if there is a cell that is going to kill
        targetIDs = int32(zeros(1,nr_killers)); % preallocate
        killerIDs = int32(zeros(1,nr_killers)); % preallocate
        blockingIDs = int32(zeros(1,nr_killers)); % preallocate
        blockedIDs = int32(zeros(1,nr_killers)); % preallocate
        % start tumor cell killing, same random order as before
        St = bsxfun(@plus,IMcells(acting_killer),nh.aux(nh.Pms(:,randi(nh.nP,1,nr_killers))));
        % iterate through all immune cells and look at their neighborhood
        for jj = 1:nr_killers
%             neighbPositold = St(randperm(length(nh.aux)),jj);     is already random due to using random order in bsxfun
            neighbPosit = St(:,jj);
            instakill = ismember(neighbPosit(:),TUcells(:));
            % if the cell encounters another cell to kill
            if sum(instakill) > 0
                % if more than 1 possible targets then use the first one
                possibleTargets = neighbPosit(instakill); % possible targets
                target = int32(possibleTargets(1)); % kill only the first candidate               
                
                if rand() > TUprop.pblock(TUcells==target) %if blocked
                    blockingIDs(jj) = target; % add blocking ID
                    blockedIDs(jj) = IMcells(acting_killer(jj)); % add blocked ID
                else
                    targetIDs(jj) = target; % add target ID to stack
                    killerIDs(jj) = IMcells(acting_killer(jj)); % add killer ID to stack                    
                end
            end
        end
        
        % remove zeros
        blockingIDs = nonzeros(blockingIDs);
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
            auxKillIM = ismember(IMcells,killerIDs); % which immmune cells do kill
            L(TUcells(auxKillTU)) = false;  % FIRST remove from L grid
            Lt(TUcells(auxKillTU)) = false;  % ... and remove from Lt grid
            [TUcells,TUprop] = removeTU(TUcells,TUprop,auxKillTU); % second, remove from stack
            IMprop.Kcap(auxKillIM) = IMprop.Kcap(auxKillIM)-1; % exhaust killers
            IMprop.engaged(auxKillIM) = engagementDuration; % killers are engaged
        end
        if blockedIDs % if blocking happens, then update
            blockingTU = ismember(TUcells,blockingIDs); % which tumor cells block an attack
            blockedIM = ismember(IMcells,blockedIDs); % which immune cells' attack was blocked
            IMprop.pdeath(blockedIM) = new_pdeath; % change probablity apoptosis immune cells
            IMprop.pprol(blockedIM) = new_pprol; % change probability proliferation immune cells
            TUprop.pblock(blockingTU) = TUprop.pblock(blockingTU)+pblock_change; % reduce pblock tumor cells
        end
    end % end actual killing filter
end % end candidate filter
end % end function
