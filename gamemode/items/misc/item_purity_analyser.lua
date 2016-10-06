local BASH = BASH;
local ITEM = {};
ITEM.ID =				"purity_analyser";
ITEM.Name =				"Purity Analyser";
ITEM.Description =		"A small handheld analyser used for checking the purity of Zone artifacts.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/sensor_c.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	0;
ITEM.DefaultPrice = 	3000;
ITEM.LootHidden =       true;

ITEM.NoProperties =     true;
BASH:ProcessItem(ITEM);
