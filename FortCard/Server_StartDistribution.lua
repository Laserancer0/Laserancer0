require('Utilities');
function Server_StartDistribution(game, standing)
--Declare Variables
	local playerData = Mod.PlayerGameData;
	for _,gp in pairs(game.Game.PlayingPlayers) do
		if (not gp.IsAI) then
			if (playerData[gp.ID] == nil) then
				playerData[gp.ID] = {};
			end
			if (playerData[gp.ID].numPieces == nil) then
				playerData[gp.ID].numPieces = Mod.Settings.startingPieces;
			end
			if (playerData[gp.ID].numCards == nil) then
					playerData[gp.ID].numCards = 0;
			end
			if (playerData[gp.ID].numPieces >= Mod.Settings.piecesInCard) then
				playerData[gp.ID].numCards = playerData[gp.ID].numCards + math.floor(playerData[gp.ID].numPieces / Mod.Settings.piecesInCard);
				playerData[gp.ID].numPieces = playerData[gp.ID].numPieces % Mod.Settings.piecesInCard;
			end	
			if (playerData[gp.ID].canGetCards == nil) then
				playerData[gp.ID].canGetCards = 0;
			end
			if (playerData[gp.ID].otherCardsCount == nil) then
				playerData[gp.ID].otherCardsCount = 0;
			end
			if (playerData[gp.ID].otherCardsUsed == nil) then
				playerData[gp.ID].otherCardsUsed = 0;
			end
			if (playerData[gp.ID].showWarning == nil) then
				playerData[gp.ID].showWarning = false;
			end
		end
	end
	Mod.PlayerGameData = playerData;
end