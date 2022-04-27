
function Client_PresentConfigureUI(rootParent)
	local killPercentage = Mod.Settings.killPercentage;
	if killPercentage == nil then killPercentage = 50; end
    local delayed = Mod.Settings.delayed;
	if delayed == nil then delayed = 0; end
	local armiesKilled = Mod.Settings.armiesKilled;
	if armiesKilled == nil then armiesKilled = 0; end
	
	
	local vert = UI.CreateVerticalLayoutGroup(rootParent);

    local row1 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row1).SetText('Amount of troops killed (in percentage)');
    killPercentageInput = UI.CreateNumberInputField(row1)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(100)
		.SetValue(killPercentage);
	local row2 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row2).SetText('Delayed: 0 = card happens at the beggining of the turn, 1 = card happens at the end of the turn.');
    delayedInput = UI.CreateNumberInputField(row2)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(1)
		.SetValue(delayed);
	local row3 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row3).SetText('Number of armies killed (absolute number, happens after percentage kill).');
    armiesKilledInput = UI.CreateNumberInputField(row3)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(15)
		.SetValue(armiesKilled);
end