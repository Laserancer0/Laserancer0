function Server_AdvanceTurn_Start (game,addNewOrder)
	skippedBombs = {};
	executed = false;
end
function Server_AdvanceTurn_Order(game, order, result, skipThisOrder, addNewOrder)	
	if(executed == false)then
		if(order.proxyType == 'GameOrderPlayCardBomb')then
			addNewOrder(WL.GameOrderDiscard.Create(order.PlayerID, order.CardInstanceID));
			if (Mod.Settings.delayed == 1) then
				skippedBombs[tablelength(skippedBombs)] = order;
			else
				PlayBombCard(game, order, addNewOrder);
			skipThisOrder(WL.ModOrderControl.SkipAndSupressSkippedMessage);
			end
		end
	end
end
function Server_AdvanceTurn_End(game,addNewOrder)
	if(executed == false) then
		executed = true;
		for _,order in pairs(skippedBombs)do
			if(game.ServerGame.Game.PlayingPlayers[order.PlayerID].Team ~= game.ServerGame.Game.PlayingPlayers[game.ServerGame.LatestTurnStanding.Territories[order.TargetTerritoryID].OwnerPlayerID].Team)then --isn't class programming neat?
				PlayBombCard(game, order, addNewOrder);
			end
		end
	end
end
function tablelength(T)
	local count = 0;
	for _ in pairs(T) do count = count + 1 end;
	return count;
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
		armies = round(armies - armies*Mod.Settings.killPercentage / 100 - Mod.Settings.armiesKilled);
		if (armies < 1) then
			terrMod.SetOwnerOpt = WL.PlayerID.Neutral;
			terrMod.SetArmiesTo = 0;
		else
			terrMod.SetArmiesTo = armies;
		end
		addNewOrder(WL.GameOrderEvent.Create(order.PlayerID, "Bomb card", {}, {terrMod}));
end
