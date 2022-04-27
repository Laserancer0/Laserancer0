
function Client_PresentSettingsUI(rootParent)
	if (Mod.Settings.killPercentage == 0) then
		if (Mod.Settings.delayed == 1) then
			UI.CreateLabel(rootParent).SetText("The card kills ".. Mod.Settings.armiesKilled.." enemy troops. If all troops are killed, the territory turns neutral. The effect happens at the end of your turn.");
		else
			UI.CreateLabel(rootParent).SetText("The card kills ".. Mod.Settings.armiesKilled.." troops. If all troops are killed, the territory turns neutral.");
	end
	else
		if (Mod.Settings.delayed == 1) then
			UI.CreateLabel(rootParent).SetText("The card kills " .. Mod.Settings.killPercentage .. "% of enemy armies on targeted territory at the end of your turn.");
		else
			UI.CreateLabel(rootParent).SetText("The card kills " .. Mod.Settings.killPercentage .. "% of enemy armies on targeted territory.");
		end
		if (Mod.Settings.armiesKilled ~= 0) then
			UI.CreateLabel(rootParent).SetText("After that, it kills ".. Mod.Settings.armiesKilled.." additional troops. If all troops are killed, the territory turns neutral.");
		end
	end
end

