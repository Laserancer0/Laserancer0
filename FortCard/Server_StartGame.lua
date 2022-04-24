require('Utilities');
function CountCards (game)
	local cardCount=0;
	for _, card in pairs(game.Settings.Cards) do
		cardCount = cardCount + math.floor(card.InitialPieces / card.NumPieces);
	end
	return cardCount;
end

function Server_StartGame(game, standing)
--Declare Variables in Auto-dist
	local playerData = Mod.PlayerGameData;
	local cardCount = CountCards (game)
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
			playerData[gp.ID].otherCardsCount = cardCount;
			if (playerData[gp.ID].otherCardsUsed == nil) then
				playerData[gp.ID].otherCardsUsed = 0;
			end
			playerData[gp.ID].showWarning = true;
		end
	end
	Mod.PlayerGameData = playerData;
end