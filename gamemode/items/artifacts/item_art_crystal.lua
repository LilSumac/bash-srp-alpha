local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_crystal";
ITEM.Name =				"Crystal";
ITEM.Description =		"Is created when heavy metals fall into the Burner anomaly. This artifact eliminates radiation wonderfully. It is highly valued by stalkers and hard to find.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/crystal.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	40000;

ITEM.IsArtifact =       true;
ITEM.BurnResist =       20;
ITEM.RadsPerMin =       20;
BASH:ProcessItem(ITEM);
