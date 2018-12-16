
function [mySystem,currentSummary] = updateSystem(mySystem,TUcells,TUprop,...
    IM1cells,IM2cells,IM1prop,IM2prop,ChtaxMap,HypoxMap,L,Lt,Ln,Lf,i,cnst)
    % copy all variables back to mySystem
    mySystem.TU.TUcells = TUcells;
    mySystem.TU.TUprop.isStem = TUprop.isStem;
    mySystem.TU.TUprop.Pcap = TUprop.Pcap;  
    mySystem.TU.TUprop.pblock = TUprop.pblock; % [added OGO 22]
    
    mySystem.IM.IM1cells = IM1cells;
    mySystem.IM.IM1prop.Kcap = IM1prop.Kcap;
    mySystem.IM.IM1prop.Pcap = IM1prop.Pcap;  
    mySystem.IM.IM1prop.engaged = IM1prop.engaged;
    mySystem.IM.IM1prop.pprol = IM1prop.pprol; % [added OGO 22]
    mySystem.IM.IM1prop.pdeath = IM1prop.pdeath; % [added OGO 22]
    
    mySystem.IM.IM2cells = IM2cells;
    mySystem.IM.IM2prop.Kcap = IM2prop.Kcap;
    mySystem.IM.IM2prop.Pcap = IM2prop.Pcap;  
    mySystem.IM.IM2prop.engaged = IM2prop.engaged;
    
    mySystem.grid.ChtaxMap = ChtaxMap;
    mySystem.grid.HypoxMap = HypoxMap;
    mySystem.grid.Ln = Ln;
    mySystem.grid.Lf = Lf;
    mySystem.grid.L = L;
    mySystem.grid.Lt = Lt;
    mySystem.grid.StepsDone = i;

    % create immune grid
    mySystem.grid.Li = false(size(L));
    mySystem.grid.Li(IM1cells) = true;
    mySystem.grid.Li(IM2cells) = true;
    
    % summarize system
    if ismatrix(L)
        currentSummary = summarizeSystem_2D(mySystem,cnst);
    elseif ndims(L) == 3
        error('not yet implemented');
    end
    
end
