function [IMcells,IMprop] = shuffleIM(IMcells,IMprop)

shf = randperm(length(IMcells)); % prepare random shuffling
IMcells = IMcells(shf); % randomly shuffle cells
IMprop.Pcap = IMprop.Pcap(shf); % shuffle Pmax property accordingly
IMprop.Kcap = IMprop.Kcap(shf); % shuffle Kmax property accordingly
IMprop.engaged = IMprop.engaged(shf); % shuffle engaged property accordingly

% [added OGO 22]
IMprop.pprol = IMprop.pprol(shf); % shuffle pprol property accordingly
IMprop.pdeath = IMprop.pdeath(shf); % shuffle pdeath property accordingly

end