
function Client_SaveConfigureUI(alert)
	local killPercentage = killPercentageInput.GetValue();
	if killPercentage < 0 or killPercentage > 100 then alert('The kill percentage must be set between 1 to 100'); end
    Mod.Settings.killPercentage = killPercentage;
	
	local delayed = delayedInput.GetValue();
	if delayed < 0 or delayed > 1 then alert('Only values 0 and 1 are acceptable on "delayed" settings'); end
    Mod.Settings.delayed = delayed;
	
	local armiesKilled = armiesKilledInput.GetValue();

	if armiesKilled < 0 or armiesKilled > 1000 then alert('Armies killed must be set between 0 to 1000'); end
    Mod.Settings.armiesKilled = armiesKilled;
end
