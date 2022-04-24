function Client_GameRefresh(game)
	local playerData = Mod.PlayerGameData;
    if (game.Us == nil or playerData.showWarning == nil or playerData.showWarning == false) then
        return
    end
	if (playerData.otherCardsCount ~= nil) then
		if (playerData.numCards + playerData.otherCardsCount > game.Settings.MaxCardsHold) then
			UI.Alert("You can hold only "..game.Settings.MaxCardsHold.. " cards. If you fail to use ".. (playerData.numCards + playerData.otherCardsCount - game.Settings.MaxCardsHold) .. " cards, appropriate number of special cards will be discarded.");
		end
	end
	game.SendGameCustomMessage("Updating server, please wait... ", {msg="WarningSeen"}, function(reply)end);
end