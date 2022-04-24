
function Client_PresentConfigureUI(rootParent)
	local piecesInCard = Mod.Settings.piecesInCard;
	if piecesInCard == nil then piecesInCard = 4; end
    local piecesPerTurn = Mod.Settings.piecesPerTurn;
	if piecesPerTurn == nil then piecesPerTurn = 1; end
	local startingPieces = Mod.Settings.startingPieces;
	if startingPieces == nil then startingPieces = 0; end
	
	
	local vert = UI.CreateVerticalLayoutGroup(rootParent);

    local row1 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row1).SetText('Number of pieces to divide the card into');
    piecesInCardInput = UI.CreateNumberInputField(row1)
		.SetSliderMinValue(1)
		.SetSliderMaxValue(15)
		.SetValue(piecesInCard);
	local row2 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row2).SetText('Number of card pieces you get each turn');
    piecesPerTurnInput = UI.CreateNumberInputField(row2)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(15)
		.SetValue(piecesPerTurn);
	local row3 = UI.CreateHorizontalLayoutGroup(vert);
	UI.CreateLabel(row3).SetText('Number of card pieces you start with');
    startingPiecesInput = UI.CreateNumberInputField(row3)
		.SetSliderMinValue(0)
		.SetSliderMaxValue(15)
		.SetValue(startingPieces);
end