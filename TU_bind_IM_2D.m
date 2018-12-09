function IMprop = TU_bind_IM_2D(IMcells,IMprop,TUcells,TUprop,L_size,pprol_change,pdeath_change,nh)
% make distance map to immune cells
Li = false(L_size);
Li(IMcells)=1;
dist_map = double(bwdist(Li,'euclidean'));

% find tumor cells with neighbouring immune cells and sufficient TUpblock
binding_TUcells = TUcells(boolean((dist_map(TUcells)<2).*(rand(1,length(TUcells))<=TUprop.TUpblock)));
% (nh.Pms(:,randi(nh.nP,1,length(bindingTUcells))))
nb_IMcells = bsxfun(@plus,binding_TUcells,nh.aux(nh.Pms(:,randi(nh.nP,1,length(binding_TUcells)))));
for i = 1:length(binding_TUcells)
    % find immune cells in the neighborhood and change their pprol and pdeath
    [~,idx] = intersect(IMcells,nb_IMcells(:,i));
    IMprop.pprol(idx) = IMprop.pprol(idx)+pprol_change;
    IMprop.pdeath(idx) = IMprop.pdeath(idx)+pdeath_change;
end
% prevent probabilities lower than 0 or higher than 1
IMprop.pprol = max(IMprop.pprol,0);
IMprop.pdeath = min(IMprop.pdeath,1);
end