function cmap = purgr(n)
   
    cmap = zeros(n,3);
    cmap(:,1) = linspace(0.24,200/255,n);
    cmap(:,2) = linspace(0,0/255,n);
    cmap(:,3) = linspace(0.3,200/255,n);
    
end