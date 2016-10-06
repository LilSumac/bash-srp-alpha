local BASH = BASH;
local ITEM = {};
ITEM.ID =				"art_shell";
ITEM.Name =				"Shell";
ITEM.Description =		"This artifact used to be considered trash, devoid of any useful properties. However, scientists recently discovered that if kept in constant contact with the body, it has an excellent stimulating effect on the nervous system, replenishing the bearer's energy. Emits radiation.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/artifacts/shell.mdl");
ITEM.Tier =             3;
ITEM.Weight =			0.5;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	12000;

ITEM.IsArtifact =       true;
ITEM.RadsPerMin =       10;
BASH:ProcessItem(ITEM);
