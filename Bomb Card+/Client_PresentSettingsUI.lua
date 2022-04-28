
function Client_PresentSettingsUI(rootParent)
	if (Mod.Settings.killPercentage == 0) then
		if (Mod.Settings.delayed) then
			if (Mod.Settings.armiesKilled == 1) then
				UI.CreateLabel(rootParent).SetText("The bomb card kills one enemy troop. If all troops are killed, targeted territory turns neutral. The effect happens at the end of your turn.");
			else
				UI.CreateLabel(rootParent).SetText("The bomb card kills ".. Mod.Settings.armiesKilled.." enemy troops. If all troops are killed, targeted territory turns neutral. The effect happens at the end of your turn.");
			end
		else
			if (Mod.Settings.armiesKilled == 1) then
				UI.CreateLabel(rootParent).SetText("The bomb card kills one troop. If all troops are killed, targeted territory turns neutral.");
			else
			UI.CreateLabel(rootParent).SetText("The bomb card kills ".. Mod.Settings.armiesKilled.." troops. If all troops are killed, target territory turns neutral.");
			end
		end
	else
		if (Mod.Settings.delayed) then
			UI.CreateLabel(rootParent).SetText("The bomb card kills " .. Mod.Settings.killPercentage .. "% of enemy armies on targeted territory at the end of your turn.");
		else
			UI.CreateLabel(rootParent).SetText("The bomb card kills " .. Mod.Settings.killPercentage .. "% of enemy armies on targeted territory.");
		end
		UI.CreateLabel(rootParent).SetText("Note, that this rounds up (if the card were to kill 0.5 troops, it would have killed 1 troop).");
		if (Mod.Settings.armiesKilled ~= 0) then
			if (Mod.Settings.armiesKilled == 1) then
				UI.CreateLabel(rootParent).SetText("After that, the card kills one additional troop. If all troops are killed, targeted territory turns neutral.");
			else
			UI.CreateLabel(rootParent).SetText("After that, the card kills ".. Mod.Settings.armiesKilled.." additional troops. If all troops are killed, targeted territory turns neutral.");
			end
		end
	end
	UI.CreateLabel(rootParent).SetText("This mod will create fake discard orders, thanks to Fizzer.");

end

