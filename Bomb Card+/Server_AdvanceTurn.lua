function Server_AdvanceTurn_Start (game,addNewOrder)
	skippedBombs = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(executed == false)then
		if(order.proxyType == 'GameOrderPlayCardBomb')then
			addNewOrder(WL.GameOrderDiscard.Create(order.PlayerID, order.CardInstanceID));
			if (Mod.Settings.delayed) then
				skippedBombs[#skippedBombs+1] = order;
			else
				PlayBombCard(game, order, addNewOrder);
			end
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
		end
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	if(executed == false) then
		executed = true;
		for _, order in pairs(skippedBombs)do
			if (game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID == WL.PlayerID.Neutral or game.ServerGame.Game.PlayingPlayers[order.PlayerID].Team~=game.ServerGame.Game.PlayingPlayers[game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID].Team or (game.ServerGame.Game.PlayingPlayers[game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID].Team == -1 and game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID ~= order.PlayerID)) then -- xD
				PlayBombCard(game, order, addNewOrder);
			end
		end
	end
end
function round (input)
	local wholePart = math.floor(input);
	local decimalPart = input - wholePart;
	if (decimalPart) >= 0.5 then
		return wholePart +1;
	else
		return wholePart;
	end
end

function PlayBombCard(game, order, addNewOrder)
		local terrMod = WL.TerritoryModification.Create(order.TargetTerritoryID);
		local armies = game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].NumArmies.NumArmies;
		armies =armies - round(armies*Mod.Settings.killPercentage / 100 + Mod.Settings.armiesKilled);
		if (armies < 1) then
			terrMod.SetOwnerOpt = WL.PlayerID.Neutral;
			terrMod.SetArmiesTo = 0;
		else
			terrMod.SetArmiesTo = armies;
		end
		addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Bomb card", {}, {terrMod}));
end
