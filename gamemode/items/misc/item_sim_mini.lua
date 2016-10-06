local BASH = BASH;
local ITEM = {};
ITEM.ID =				"sim_mini";
ITEM.Name =				"Mini-SIM Card";
ITEM.Description =		"A miniscule electronic chip that identifies its user to the STALKERnet.";
ITEM.FlavorText =		"You got a Kik, STALKER?";
ITEM.WorldModel =		Model("models/props_lab/clipboard.mdl");
ITEM.ModelScale =		0.25;
ITEM.DefaultStock = 	1000;
ITEM.DefaultPrice = 	100;
ITEM.LootHidden =       true;

ITEM.IsSIMCard =		true;
BASH:ProcessItem(ITEM);
