local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_bubble";
ITEM.Name =				"Bubble";
ITEM.Description =		"A compound of several hollow organic formations, this artifact emits a gaseous substance that can neutralize radioactive particles inside the body. This artifact is extremely valuable.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/bubble.mdl");
ITEM.Tier =             5;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	45000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       -40;
BASH:ProcessItem(ITEM);
