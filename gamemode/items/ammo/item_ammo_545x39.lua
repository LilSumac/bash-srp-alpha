local BASH = BASH;
local ITEM = {};
ITEM.ID =				"ammo_545x39";
ITEM.Name =				"5.45x39mm Rounds";
ITEM.Description =		"A box of rimless rifle cartridges developed for Warsaw small arms.";
ITEM.FlavorText =		"";
ITEM.WorldModel =		Model("models/stalker/ammo/545x39.mdl");
ITEM.Weight =			0.01;
ITEM.DefaultStock = 	3000;
ITEM.DefaultPrice = 	300;
ITEM.IsStackable =		true;
ITEM.DefaultStacks =    30;
ITEM.MaxStacks =        300;
BASH:ProcessItem(ITEM);