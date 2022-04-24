function Client_GameRefresh(game)
	local playerData = Mod.PlayerGameData;
	if (playerData.otherCardsCount ~= nil and playerData.otherCardsCount ~= -1) then
		if (playerData.numCards + playerData.otherCardsCount > game.Settings.MaxCardsHold) then
			UI.Alert("You can hold only "..game.Settings.MaxCardsHold.. " cards. If you fail to use ".. (playerData.numCards + playerData.otherCardsCount - game.Settings.MaxCardsHold) .. " cards, appropriate number of special cards will be discarded.");
		end
	end

end