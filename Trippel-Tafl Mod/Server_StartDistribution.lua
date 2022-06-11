require('Utilities');

function Server_StartDistribution(game, standing)
    
	if (not WL.IsVersionOrHigher or not WL.IsVersionOrHigher("5.17")) then
		error("You must update your app to the latest version to use the Hybrid Distribution mod");
		return;
	end
	--Get players
	players = game.ServerGame.Game.Players
	IDs = {};
	for _, player in pairs(players) do
		table.insert(IDs, player.ID);
	end	
	if (#IDs ~=2) then
		return;
	end

	--Distribute Castles
    local castles = {};

    for _,territory in pairs(game.Map.Territories) do
        if string.match(territory.Name, "Castle") then
            table.insert(castles, territory);
		end

    end
    shuffle(castles);
	standing.Territories[castles[1].ID].OwnerPlayerID = IDs[1];
	standing.Territories[castles[1].ID].NumArmies = WL.Armies.Create(game.Settings.InitialPlayerArmiesPerTerritory);
	standing.Territories[castles[2].ID].OwnerPlayerID = IDs[2];
	standing.Territories[castles[2].ID].NumArmies = WL.Armies.Create(game.Settings.InitialPlayerArmiesPerTerritory);
	standing.Territories[castles[3].ID].OwnerPlayerID = WL.PlayerID.Neutral;
	standing.Territories[castles[3].ID].NumArmies =WL.Armies.Create(game.Settings.InitialNonDistributionArmies);
	
	if string.match(castles[3].Name, "Green") then
		colour = "Green"
	else	if string.match(castles[3].Name, "Red") then
				colour = "Red" 
			else
				colour = "Blue"
			end
	end
	
	for _, bonus in pairs(game.Map.Bonuses) do
		if string.match(bonus.Name, colour) and (string.len(bonus.Name) == string.len(colour)+2 or string.len(bonus.Name) == string.len(colour)+3) then
			territories = {};
			for _, terr in pairs(bonus.Territories) do
				if not string.match(game.Map.Territories[terr].Name, "Castle") then
				    table.insert(territories, terr);
				end
			end
			shuffle(territories);
			for i=2, #territories do 
				if standing.Territories[territories[i]].OwnerPlayerID == WL.PlayerID.AvailableForDistribution then
					standing.Territories[territories[i]].OwnerPlayerID = WL.PlayerID.Neutral;
					standing.Territories[territories[i]].NumArmies = WL.Armies.Create(game.Settings.InitialNonDistributionArmies);
				end
			end
		end
	end

end

