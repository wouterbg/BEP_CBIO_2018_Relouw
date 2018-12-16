function [L,IMcells,IMprop] = IMinflux(L,IMcells,IMprop,IMpmax,IMkmax,IMinflRate,IMpprol,IMpdeath)

if IMinflRate>0 % if an immune influx is desired
    % if there are empty locations
    if sum(~L(:))>0
        % place N immune cells in empty locations
        [~,coordsNewIMcells] = datasample(L(:),IMinflRate,'Replace',false,'Weights',uint8(~L(:)));
        % InfluxMap = rand(size(L)) <= IMinfluxProb; % find random places
        % InfluxMap(L) = false; % only empty grid cells
        L(coordsNewIMcells) = true; % place new cells on grid
        nNewCells = numel(coordsNewIMcells); % number of new immune cells
        IMcells = [IMcells, coordsNewIMcells]; % add new cells to stack
        IMprop.Pcap = [IMprop.Pcap, repmat(IMpmax,1,nNewCells)];    % add properties
        IMprop.Kcap = [IMprop.Kcap, repmat(IMkmax,1,nNewCells)];    % add properties
        IMprop.engaged = [IMprop.engaged, zeros(1,nNewCells)];      % add properties
        if length(fieldnames(IMprop)) == 5 % if immune cell type 1 [added OGO 22]
            IMprop.pprol = [IMprop.pprol, repmat(IMpprol,1,nNewCells)];     % add default proliferation probability [added OGO 22]
            IMprop.pdeath = [IMprop.pdeath, repmat(IMpdeath,1,nNewCells)];  % add default death probability [added OGO 22]
        end
    end
end
end