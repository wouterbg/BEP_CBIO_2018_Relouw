function [L, TUcells, IM1cells, IM2cells, TUprop, IM1prop, IM2prop] = initializeSystem_2D(N,M,TUpmax)
    
    % START INITIALIZE GRID  -------------------------------------------
    L = false(N,M);
    % END INITIALIZE GRID  ----------------------------------------------
    
    % START INITIALIZE TUMOR CELLS -------------------------------------------
    TUcells = int32(N*round(M/2)-round(N/2)); % first TU cell is centered
    L(TUcells) = true; 			 % place first tumor cell on the grid
    TUprop.isStem = true;        % set property of first cell: stemness
    TUprop.Pcap = uint8(TUpmax); % set property of first cell: proliferation capacity
    
    
    
    %%%%% Added 03-12-2018 OGO CB Group 22
%     TUprop.TUpblock = double([]); % add properties: proliferation probability
    %%%%%
    
        
    
    % END INITIALIZE TUMOR CELLS ---------------------------------------------

    % START INITIALIZE IMMUNE CELLS (LYMPHOCYTES) -----------------------------
    IM1cells = int32([]); 	 % preallocate immune cell position vector
    IM1prop.Pcap = uint8([]); % add properties: max proliferation capacity
    IM1prop.Kcap = uint8([]); % add properties: max killing capacity
    IM1prop.engaged = uint8([]); % add properties: engagement in killing
    
    
    %%%%% Added 02-12-2018 OGO CB Group 22
    IM1prop.pprol = double([]); % add properties: proliferation probability
    IM1prop.pdeath = double([]); % add properties: death probability
    %%%%%
    
    
     % END INITIALIZE IMMUNE CELLS --------------------------------------------
     
    % START INITIALIZE IMMUNE CELLS (NEW TYPE....?) -----------------------------
    IM2cells = int32([]); 	 % preallocate immune cell position vector
    IM2prop.Pcap = uint8([]); % add properties: max proliferation capacity
    IM2prop.Kcap = uint8([]); % add properties: max killing capacity
    IM2prop.engaged = uint8([]); % add properties: engagement in killing
    
    
    %%%%% Added 02-12-2018 OGO CB Group 22
    IM2prop.pprol = double([]); % add properties: proliferation probability
    IM2prop.pdeath = double([]); % add properties: death probability
    %%%%%
    
    
     % END INITIALIZE IMMUNE CELLS --------------------------------------------

end