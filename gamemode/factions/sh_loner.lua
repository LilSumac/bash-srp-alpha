local BASH = BASH;
local FACTION = {};
FACTION.ID = "loner";
FACTION.Name = "Loners";
FACTION.Description = "STALKERs that hold no official affiliation. They are hunters, robbers, vigilantes, and ne'er-do-wells."
FACTION.Color = Color(0, 120, 0, 255);
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
FACTION.Default = true;
BASH:ProcessFaction(FACTION);
