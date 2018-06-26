function plausible = checkPlausibility(mySystem)
plausible = true;

if sum([mySystem.params.TUpprol,mySystem.params.TUpmig,mySystem.params.TUpdeath])>1
    warning('Tumor parameter error');
    plausible = false;
end

if sum([mySystem.params.IM1pprol,mySystem.params.IM1pmig,mySystem.params.IM1pdeath])>1
    warning('Immune cell 1 parameter error');
    plausible = false;
    
if sum([mySystem.params.IM2pprol,mySystem.params.IM2pmig,mySystem.params.IM2pdeath])>1
    warning('Immune cell 2 parameter error');
    plausible = false;

end

    

end