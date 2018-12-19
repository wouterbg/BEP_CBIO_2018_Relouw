function pblock = IM_IFN_effect(IM1cells,TUcells,L_size,TUpblock_start,TUpblock_change,disk,effImmuno)
% Change the TUpblock parameter for the tumor cells in the neighborhood of
% immune cells
tot = false(L_size);

% find the active immune cells, so the cells with neighbouring tumor cells
L_n = tot;
L_n(TUcells) = 1;
dist_map = double(bwdist(L_n,'euclidean'));
IM1cells_on = IM1cells(boolean((dist_map(IM1cells)<=1)));

% apply convolution with the filter to calculate IFN gamma concentrations
% and see the active immune cells as point sources
temp = tot;
temp(IM1cells_on) = 1;
tot = conv2(temp,disk,'same');

% put pblock values in list with max value of 1
pblock = min((TUpblock_start+tot(TUcells).*TUpblock_change)*(1-effImmuno),1);
end