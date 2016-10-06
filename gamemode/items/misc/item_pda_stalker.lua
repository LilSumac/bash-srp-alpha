local BASH = BASH;
local ITEM = {};
ITEM.ID =				"pda_stalker";
ITEM.Name =				"STALKER PDA";
ITEM.Description =		"A small digital device built with a sturdy metal case. Perfect for communication within the Zone.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/kali/miscstuff/stalker/pda.mdl");
ITEM.Weight =			0.25;
ITEM.DefaultStock = 	1000;
ITEM.DefaultPrice = 	100;
ITEM.MetalYield =		3;
ITEM.LootHidden =       true;

ITEM.IsPDA =			true;
BASH:ProcessItem(ITEM);
