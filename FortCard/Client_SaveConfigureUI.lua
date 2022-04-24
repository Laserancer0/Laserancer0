
function Client_SaveConfigureUI(alert)
	local piecesInCard = piecesInCardInput.GetValue();
	if piecesInCard < 1 or piecesInCard > 100 then alert('Number of pieces to divide the card into must be set between 1 to 100'); end
    Mod.Settings.piecesInCard = piecesInCard;
	
	local piecesPerTurn = piecesPerTurnInput.GetValue();
	if piecesPerTurn < 0 or piecesPerTurn > 1000 then alert('Number of card pieces you get each turn must be set between 0 to 1000'); end
    Mod.Settings.piecesPerTurn = piecesPerTurn;
	
	local startingPieces = startingPiecesInput.GetValue();

	if startingPieces < 0 or startingPieces > 1000 then alert('Number of card pieces you start with must be set between 0 to 100'); end
    Mod.Settings.startingPieces = startingPieces;
end
