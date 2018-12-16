function [m, idx] = getAdjacent_2D(L,MYcells,nh)
m.S = bsxfun(@plus,MYcells,nh.aux(nh.Pms(:,randi(nh.nP,1,length(MYcells)))));
m.S(L(m.S)) = 0; 			% setting occupied grid cells to false
bool_list = any(m.S);
m.indxF = find(bool_list); 	% selecting agents with at least one free spot
idx = (bool_list == 1);     % idx list to ommit pprol and pdeath values for omitted cells this iteration [added OGO 22]
m.nC = length(m.indxF); 	% number of agents with free spot
m.randI = rand(1,m.nC); 	% initialize random number vector

end