local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_night_star";
ITEM.Name =				"Night Star";
ITEM.Description =		"This glowing artifact can create a local directed low-gravity field. Reduces the weight of backpacks when placed near them. Widely used to increase maximum load. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/night star.mdl");
ITEM.Tier =             4;
ITEM.Weight =			-5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	20000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       15;
BASH:ProcessItem(ITEM);
