% JN Kather 2017, jakob.kather@nct-heidelberg.de

function [mySystem, finalImage, finalSummary, imWin, fcount] = ...
    growTumor_2D(mySystem,cnst)
% growTumor_2D performs the actual agent-based modeling in 2D
%       input are two structures: mySystem, defining the initial state of
%       the system; and cnst, defining some global constants

% START PREPARATIONS -------------------------------------------
% throw all model parameters to workspace
cellfun(@(f) evalin('caller',[f ' = mySystem.params.' f ';']), fieldnames(mySystem.params));
cellfun(@(f) evalin('caller',[f ' = mySystem.grid.' f ';']), fieldnames(mySystem.grid));
if cnst.createNewSystem % create a new (empty) system
    [L, TUcells, IM1cells, IM2cells, TUprop, IM1prop, IM2prop] = initializeSystem_2D(N,M,TUpmax);    
    TUprop.pblock = TUpblock_start; % starting tumor cell in the middle [added OGO 22]    
    Ln = false(size(L));    % initialize necrosis map
    Lf = false(size(L));    % initialize fibrosis map
else % use existing system and grow it further
    cellfun(@(f) evalin('caller',[f ' = mySystem.TU.' f ';']), fieldnames(mySystem.TU));
    cellfun(@(f) evalin('caller',[f ' = mySystem.IM.' f ';']), fieldnames(mySystem.IM));
end
% END PREPARATIONS -------------------------------------------

% START INITIALIZE AUX VARIABLES  ----------------------------------------
nh = neighborhood_2D(N);   % get neighborhood indices
L = setEdge_2D(L,true);    % set boundary to occupied
rng(initialSeed);       % reset random number generator 
imWin = 0;              % set immune win flag to 0
fcount = 0;             % frame counter for video export
finalImage = [];        % set empty resulting image
% END INITIALIZE AUX VARIABLES   -----------------------------------------

% START ITERATION
for i = 1:cnst.nSteps % iterate through time steps

% START TUMOR CELL ROUND ------------------------------------------------
L(Lf) = rand(sum(Lf(:)),1)>stromaPerm; % permeabilize some stroma-filled grid cells
L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
[TUcells,TUprop] = shuffleTU(TUcells,TUprop);
[L, TUcells, TUprop] = TU_go_grow_die_2D( L, nh, TUcells, TUprop, TUpprol, TUpmig, TUpdeath, TUps, TUpblock_start);
Lt = updateTumorGrid(L,TUcells); % update tumor grid
% END TUMOR CELL ROUND ---------------------------------------------------

% START MODIFY PARAMETER MAPS --------------------------------------------
[ChtaxMap, HypoxMap] = updateParameterMaps(Lt,Ln,Lf,fillSE,distMaxNecr);
% END MODIFY PARAMETER MAPS

% [modified] START IMMUNE CELL ROUND (LYMPHOCYTES) ------------------------------------------------
L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
if rand()<=IM1influxProb % randomly trigger influx
[L,IM1cells,IM1prop] = IMinflux(L,IM1cells,IM1prop,IM1pmax,IM1kmax,IM1inflRate,IM1pprol_std,IM1pdeath_std);
end

[IM1cells,IM1prop] = shuffleIM(IM1cells,IM1prop); % randomly shuffle immune cells

if numel(IM1cells)>0 % if there are any immune cells
for j = 1:(IM1speed-1) % allow immune cells to move N times per round
    L(Ln) = false; % for immune cell movement, necrosis is invisible
    L(Lf) = rand(sum(Lf(:)),1)>stromaPerm; % permeabilize some stroma-filled grid cells
    L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
    [L, IM1cells] =  IM_go_2D(IM1cells, IM1pmig, IM1rwalk, ChtaxMap, L, nh);
    TUprop.pblock = IM_IFN_effect(IM1cells,TUcells,size(L),TUpblock_start,TUpblock_change,IFN_effect_disk,effImmuno); % update pblocks [added OGO 22]
    [TUcells, TUprop, IM1cells, IM1prop, L, Lt] = ... % IM attack TU and TU can block [changed OGO 22]       
    IM_vs_TU_2D(TUcells, TUprop, IM1cells, IM1prop, L, Lt,IM1pkill,nh,ChtaxMap,engagementDuration,IM1pprol_low,IM1pdeath_high);    
    IM1prop.engaged(IM1prop.engaged>0) = IM1prop.engaged(IM1prop.engaged>0)-1; % un-engage lymphocytes
end

% allow immune cells to move once more or to proliferate or die
[L, IM1cells, IM1prop] =  IM_go_grow_die_2D(IM1cells, IM1prop, IM1prop.pprol, IM1pmig, ...
        IM1prop.pdeath, IM1rwalk, IM1kmax, ChtaxMap, L, nh); 
end % end (if there are any immune cells)

L(Ln|Lf) = true; % fully turn on necrosis and fibrosis again
L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
% END IMMUNE CELL ROUND --------------------------------------------------

% [added] START IMMUNE CELL ROUND (NEW TYPE....?) ------------------------------------------------
L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
if rand()<=IM2influxProb % randomly trigger influx
    [L,IM2cells,IM2prop] = IMinflux(L,IM2cells,IM2prop,IM2pmax,IM2kmax,IM2inflRate,IM2pprol,IM2pdeath);
end

[IM2cells,IM2prop] = shuffleIM(IM2cells,IM2prop); % randomly shuffle immune cells

if numel(IM2cells)>0 % if there are any immune cells 
for j = 1:(IM2speed-1) % allow immune cells to move N times per round
    L(Ln) = false; % for immune cell movement, necrosis is invisible
    L(Lf) = rand(sum(Lf(:)),1)>stromaPerm; % permeabilize some stroma-filled grid cells
    L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
    [L, IM2cells] =  IM_go_2D(IM2cells, IM2pmig, IM2rwalk, ChtaxMap, L, nh);
    [IM1cells, IM1prop, IM2cells, IM2prop, L, Lt] = ... % immune cells 1 exhaustion by immune cells 2
    IM2_attack_IM1_2D(IM1cells, IM1prop, IM2cells, IM2prop, L, Lt,IM2pkill,nh,ChtaxMap,engagementDuration);
    IM2prop.engaged(IM2prop.engaged>0) = IM2prop.engaged(IM2prop.engaged>0)-1; % un-engage immune cells 2
end
% allow immune cells to move once more or to proliferate or die
[L, IM2cells, IM2prop] =  IM_go_grow_die_2D(IM2cells, IM2prop, IM2pprol, IM2pmig, ...
        IM2pdeath, IM2rwalk, IM2kmax, ChtaxMap, L, nh); 
end % end (if there are any immune cells)

L(Ln|Lf) = true; % fully turn on necrosis and fibrosis again
L([IM2cells,IM1cells,TUcells]) = true; % ensure that all cells are present on the grid
% END IMMUNE CELL ROUND --------------------------------------------------

% START NECROSIS  --------------------------------------------
necrNum = sum(rand(numel(TUcells),1) <= probSeedNecr);
if numel(TUcells)>1 && necrNum>0 % seed necrosis
    seedCoords = randsample(TUcells,necrNum,true,HypoxMap(TUcells));
    necrosisSeeds = false(N,M);
    necrosisSeeds(seedCoords) = true; 
    % disp([num2str(necrNum), ' cell(s) will trigger necrosis']);
    % smooth and expand necrotic seed map
    necrosisSeeds = expandSeedMap(necrosisSeeds,smoothSE,necrFrac);
    seedCoords = find(necrosisSeeds);
    targetIdx = ismember(TUcells,seedCoords); % find indexes of erased tumor cells
    Lt(TUcells(targetIdx)) = false; % remove cell from grid Lt
    Ln(TUcells(targetIdx)) = true; % add to necrosis grid    
    [TUcells,TUprop] = removeTU(TUcells,TUprop,targetIdx); % second, remove from stack
end
% END NECROSIS  ----------------------------------------------

% START FIBROSIS ------------------------------------------------------
fibrosify = ~IM1prop.Kcap & (rand(1,numel(IM1cells))<probSeedFibr);
if sum(fibrosify) % exchausted immune cells seed fibrosis
    Lfseed = false(size(L)); % preallocate fibrosis seed map
    Lfseed(IM1cells(fibrosify)) = true;
    Lfseed = expandSeedMap(Lfseed,smoothSE,fibrFrac); % smooth and expand fibrotic seed map
    Lfseed(TUcells) = false;
    Lf(Lfseed & ~Ln) = true; % update fibrosis grid
    [IM1cells,IM1prop] = removeIM(IM1cells,IM1prop,fibrosify); % remove fibrosifying immune cells
    L(Lf) = true; % update L grid (master grid)
end
% END FIBROSIS ----------------------------------------------------------

% [modified] START DRAWING ---------------------------------------------------------
tumorIsGone = (sum(Lt(:))==0);
if (mod(i-1,cnst.drawWhen)==cnst.drawWhen-1) || tumorIsGone % plot status after N epochs 
    fcount = fcount+1;
    disp(['finished iteration ',num2str(i)]);
    % export current state of the system
    [mySystem,currentSummary] = updateSystem(mySystem,TUcells,TUprop,...
        IM1cells,IM2cells,IM1prop,IM2prop,ChtaxMap,HypoxMap,L,Lt,Ln,Lf,i,cnst);
    if cnst.verbose % enforce drawing and create image from plot
        visualize_balls_2D_blank(mySystem);
        drawnow, currFrame = getframe(gcf);
        finalImage{fcount} = currFrame.cdata;
        finalSummary{fcount} = currentSummary;
    else
        finalImage = []; finalSummary = [];
    end
end
% END DRAWING -----------------------------------------------------------

% if there are no tumor cells anymore then the game is over
if tumorIsGone
    disp('Immune cells win');
    imWin = i;
    return
end
if debugmode && findInconsistency(Lt,Lf,Ln,TUcells,IM1cells,IM2cells,TUprop,IM1prop,IM2prop)  
     error('SEVERE ERROR: INCONSISTENCY FOUND');
end % END DEBUG
end % END ITERATION
end % END FUNCTION
        