local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_flame";
ITEM.Name =				"Flame";
ITEM.Description =		"This rare artifact forms in areas of high thermal activity. Emits powerful infrared emissions, which intensify metabolic processes, healing wounds before its bearer's very eyes. This artifact is extremely valuable, but emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/flame.mdl");
ITEM.Tier =             4;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	30000;

ITEM.IsArtifact =       true;
ITEM.BurnResist =       20;
ITEM.RadsPerMin =       30;
BASH:ProcessItem(ITEM);
