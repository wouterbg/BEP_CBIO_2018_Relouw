function [IMcells,IMprop] = removeIM(IMcells,IMprop,idx)
IMcells(idx) = [];          % remove from stack
IMprop.Pcap(idx) = [];      % remove Pmax property
IMprop.Kcap(idx) = [];      % remove Kmax property
IMprop.engaged(idx) = [];   % remove engagement property
if length(fieldnames(IMprop)) == 5 % if immune cell type 1 [added OGO 22]
    IMprop.pprol(idx) = [];     % remove proliferation probability property [added OGO 22]
    IMprop.pdeath(idx) = [];    % remove death probability property [added OGO 22]    
end
end

