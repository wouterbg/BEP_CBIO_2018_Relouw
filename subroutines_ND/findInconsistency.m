function out = findInconsistency(Lt,Lf,Ln,TUcells,IM1cells,IM2cells,TUprop,IM1prop,IM2prop)   
disp('checking for inconsistency...');

	% [modified] perform basic consistency checks...
   c(1) = numel(TUcells) == sum(Lt(:));
   c(2) = numel(TUcells) == numel(TUprop.Pcap);
   c(3) = numel(TUcells) == numel(TUprop.isStem); 
   c(4) = numel(IM1cells) == numel(IM1prop.Pcap); 
   c(5) = numel(IM1cells) == numel(IM1prop.Kcap); 
   c(6) = numel(IM2cells) == numel(IM2prop.Pcap); 
   c(7) = numel(IM2cells) == numel(IM2prop.Kcap);
   c(8) = ~sum(Ln(TUcells));
   c(9) = ~sum(Lt(IM1cells));
   c(10) = ~sum(Lt(IM2cells));
   c(11) = ~sum(Lf(TUcells)); 
   out = any(~c);
   
   if out % error occured
       disp(c);
   else
	   disp('no problem found');
   end
end