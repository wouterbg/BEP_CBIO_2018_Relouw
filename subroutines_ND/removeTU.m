function [TUcells,TUprop] = removeTU(TUcells,TUprop,idx)
TUcells(idx) = [];           % remove from stack
TUprop.isStem(idx) = [];     % remove stemness property
TUprop.Pcap(idx) = [];       % remove Pmax property
TUprop.pblock(idx) = [];     % remove block probability property [added OGO 22]    
end