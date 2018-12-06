function [IMcells,IMprop] = removeIM(IMcells,IMprop,idx)
    IMcells(idx) = [];          % remove from stack
    IMprop.Pcap(idx) = [];      % remove Pmax property
    IMprop.Kcap(idx) = [];      % remove Kmax property
    IMprop.engaged(idx) = [];   % remove engagement property
    
    
    %%%%% Added 02-12-2018 OGO CB Group 22
    IMprop.pprol(idx) = [];     % remove proliferation probability property
    IMprop.pdeath(idx) = [];    % remove death probability property
    %%%%%
    
end

