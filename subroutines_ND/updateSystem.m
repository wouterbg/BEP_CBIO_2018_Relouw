
function [mySystem,currentSummary] = updateSystem(mySystem,TUcells,TUprop,...
    IM1cells,IM2cells,IM1prop,IM2prop,ChtaxMap,HypoxMap,L,Lt,Ln,Lf,i,cnst)
    % copy all variables back to mySystem
    mySystem.TU.TUcells = TUcells;
    mySystem.TU.TUprop.isStem = TUprop.isStem;
    mySystem.TU.TUprop.Pcap = TUprop.Pcap;
    
    % Added 03-12-2018 OGO CB Group 22
    mySystem.TU.TUprop.pblock = TUprop.pblock;
    
    mySystem.IM.IM1cells = IM1cells;
    mySystem.IM.IM1prop.Kcap = IM1prop.Kcap;
    mySystem.IM.IM1prop.Pcap = IM1prop.Pcap;  
    mySystem.IM.IM1prop.engaged = IM1prop.engaged;
    
    % Added 03-12-2018 OGO CB Group 22
    mySystem.IM.IM1prop.pprol = IM1prop.pprol;
    mySystem.IM.IM1prop.pdeath = IM1prop.pdeath;
    %%%%%
    
    mySystem.IM.IM2cells = IM2cells;
    mySystem.IM.IM2prop.Kcap = IM2prop.Kcap;
    mySystem.IM.IM2prop.Pcap = IM2prop.Pcap;  
    mySystem.IM.IM2prop.engaged = IM2prop.engaged;
    
    % Added 03-12-2018 OGO CB Group 22
    mySystem.IM.IM2prop.pprol = IM2prop.pprol;
    mySystem.IM.IM2prop.pdeath = IM2prop.pdeath;
    %%%%%
    
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
