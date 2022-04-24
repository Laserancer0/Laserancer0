require('Utilities')
function getCardData () 
	local numPieces
	local numCards
	if (Mod.PlayerGameData.numPieces == nil) then
		numPieces = Mod.Settings.startingPieces;
		
	else
		numPieces = Mod.PlayerGameData.numPieces;
	end
	if (Mod.PlayerGameData.numCards == nil) then
		numCards = 0;
	else
		numCards = Mod.PlayerGameData.numCards;
	end
	
	if (numPieces >= Mod.Settings.piecesInCard) then
		numCards = numCards + math.floor(numPieces  / Mod.Settings.piecesInCard);
		numPieces = numPieces % Mod.Settings.piecesInCard;		
	end
	return numPieces, numCards;
end
function Client_PresentMenuUI(rootParent, setMaxSize, setScrollable, game, close)

	if (not WL.IsVersionOrHigher or not WL.IsVersionOrHigher("5.17")) then
		UI.Alert("You must update your app to the latest version to use the Build Fort mod");
		return;
	end

	Game = game;
	Close = close;
	
	setMaxSize(350, 350);

	vert = UI.CreateVerticalLayoutGroup(rootParent).SetFlexibleWidth(1); --set flexible width so things don't jump around while we change InstructionLabel
	local numPieces, numCards = getCardData();

	UI.CreateLabel(vert).SetText("You currently have " .. numCards .. " cards and " .. numPieces .. " pieces.");
	UI.CreateLabel(vert).SetText("One card splits into: " .. Mod.Settings.piecesInCard .. " pieces and you get " ..Mod.Settings.piecesPerTurn .." pieces per turn.");
	UI.CreateLabel(vert).SetText("Note that forts get built at the end of your turn, so use caution when building on a territory you may lose control of.");

	SelectTerritoryBtn = UI.CreateButton(vert).SetText("Select Territory").SetOnClick(SelectTerritoryClicked);
	SelectTerritoryBtn.SetInteractable(numCards > 0);
	TargetTerritoryInstructionLabel = UI.CreateLabel(vert).SetText("");

	BuildFortBtn = UI.CreateButton(vert).SetText("Build Fort").SetOnClick(BuildFortClicked).SetInteractable(false);

end

function SelectTerritoryClicked()
	UI.InterceptNextTerritoryClick(TerritoryClicked);
	TargetTerritoryInstructionLabel.SetText("Please click on the territory you wish to build the fort on.  If needed, you can move this dialog out of the way.");
	SelectTerritoryBtn.SetInteractable(false);
end

function TerritoryClicked(terrDetails)
	SelectTerritoryBtn.SetInteractable(true);

	if (terrDetails == nil) then
		--The click request was cancelled.   Return to our default state.
		TargetTerritoryInstructionLabel.SetText("");
		SelectedTerritory = nil;
		BuildFortBtn.SetInteractable(false);
	else
		if (Game.Us.ID ~= Game.LatestStanding.Territories[terrDetails.ID].OwnerPlayerID) then
			TargetTerritoryInstructionLabel.SetText("You must own selected territory.");
			SelectedTerritory = nil;
			BuildFortBtn.SetInteractable(false);
		--Territory was clicked, remember it
		else
		TargetTerritoryInstructionLabel.SetText("Selected territory: " .. terrDetails.Name);
		SelectedTerritory = terrDetails;
		BuildFortBtn.SetInteractable(true);
		end
	end
end


function BuildFortClicked()
	local msg = 'Build a fort on ' .. SelectedTerritory.Name;
	local payload = 'BuildFort_' .. SelectedTerritory.ID;

	local orders = Game.Orders;
	table.insert(orders, WL.GameOrderCustom.Create(Game.Us.ID, msg, payload));
	Game.Orders = orders;

	Close();
end