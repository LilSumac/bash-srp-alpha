local BASH = BASH;
local FACTION = {};
FACTION.ID = "mutant";
FACTION.Name = "Mutants";
FACTION.Description = "Former fauna turned beastly upon exposure to deadly amounts of radiation and other Zone anomalies."
FACTION.Color = Color(255, 150, 0, 255);
FACTION.MaleModels = {
	Model("models/stalkertnb/rodent1.mdl"),
	Model("models/stalkertnb/dog1.mdl"),
	Model("models/stalkertnb/dog2.mdl"),
	Model("models/stalkertnb/zombie1.mdl"),
	Model("models/stalkertnb/zombie2.mdl")
};
FACTION.FemaleModels = FACTION.MaleModels;
BASH:ProcessFaction(FACTION);
