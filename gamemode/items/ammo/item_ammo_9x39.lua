local BASH = BASH;
local ITEM = {};
ITEM.ID =				"ammo_9x39";
ITEM.Name =				"9x39mm Rounds";
ITEM.Description =		"A box of subsonic Soviet rifles rounds designed for suppressed firearms.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/ammo/9x39.mdl");
ITEM.LootHidden =       true;
ITEM.Weight =			0.01;
ITEM.DefaultStock = 	3000;
ITEM.DefaultPrice = 	600;
ITEM.IsStackable =		true;
ITEM.DefaultStacks =    30;
ITEM.MaxStacks =        300;
BASH:ProcessItem(ITEM);
