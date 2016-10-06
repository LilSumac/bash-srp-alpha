local BASH = BASH;
local FACTION = {};
FACTION.ID = "clearsky";
FACTION.Name = "Clear Sky";
FACTION.Description = "A scientifically-centered group whose aim is to research the Zone's inner workings."
FACTION.Color = Color(150, 150, 255, 255);
FACTION.TextColor = color_black;
FACTION.HasStockpile = true;
FACTION.MaleModels = {
	Model("models/stalkertnb/bandit_male1.mdl"),
	Model("models/stalkertnb/bandit_male2.mdl"),
	Model("models/stalkertnb/bandit_male3.mdl"),
	Model("models/stalkertnb/bandit_male4.mdl"),
	Model("models/stalkertnb/bandit_male5.mdl")
};
FACTION.FemaleModels = {
	Model("models/stalkertnb/bandit_female1.mdl"),
	Model("models/stalkertnb/bandit_female2.mdl"),
	Model("models/stalkertnb/bandit_female3.mdl"),
	Model("models/stalkertnb/bandit_female4.mdl"),
	Model("models/stalkertnb/bandit_female5.mdl"),
	Model("models/stalkertnb/bandit_female6.mdl"),
	Model("models/stalkertnb/bandit_female7.mdl"),
	Model("models/stalkertnb/bandit_female71.mdl"),
	Model("models/stalkertnb/bandit_female8.mdl")
};
BASH:ProcessFaction(FACTION);
