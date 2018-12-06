function [TUcells,TUprop] = removeTU(TUcells,TUprop,idx)

TUcells(idx) = [];           % remove from stack
TUprop.isStem(idx) = [];     % remove stemness property
TUprop.Pcap(idx) = [];       % remove Pmax property


%%%%% Added 03-12-2018 OGO CB Group 22
% TUprop.TUpblock(idx) = [];     % remove block probability property
%%%%%
    
end