
function Client_PresentSettingsUI(rootParent)
	UI.CreateLabel(rootParent).SetText("One card splits into " .. Mod.Settings.piecesInCard .. " pieces and you get " ..Mod.Settings.piecesPerTurn .." pieces per turn.");
	UI.CreateLabel(rootParent).SetText("Every player starts with ".. Mod.Settings.startingPieces.." card pieces.")
end

