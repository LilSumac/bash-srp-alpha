local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_mamas_beads";
ITEM.Name =				"Mama's Beads";
ITEM.Description =		"A strange little thing.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/mama's beads.mdl");
ITEM.Tier =             5;
ITEM.Weight =			2;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       25;
BASH:ProcessItem(ITEM);
