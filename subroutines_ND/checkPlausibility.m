function plausible = checkPlausibility(mySystem)
plausible = true;

if sum([mySystem.params.TUpprol,mySystem.params.TUpmig,mySystem.params.TUpdeath])>1
    warning('Tumor parameter error');
    plausible = false;
end

if sum([mySystem.params.IM1pprol_std,mySystem.params.IM1pmig,mySystem.params.IM1pdeath_std])>1
    warning('Immune cell 1 parameter error');
    plausible = false;
end

if sum([mySystem.params.IM1pprol_low,mySystem.params.IM1pmig,mySystem.params.IM1pdeath_high])>1 % [added OGO 22]
    warning('Immune cell 1 parameter error');
    plausible = false;
end
    
if sum([mySystem.params.IM2pprol,mySystem.params.IM2pmig,mySystem.params.IM2pdeath])>1
    warning('Immune cell 2 parameter error');
    plausible = false;

end
end