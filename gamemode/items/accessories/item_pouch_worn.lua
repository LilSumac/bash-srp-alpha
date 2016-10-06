local BASH = BASH;
local ITEM = {};
ITEM.ID =				"pouch_worn";
ITEM.Name =				"Worn Pouch";
ITEM.Description =		"A small worn pouch for the light travellers.";
ITEM.FlavorText =		"It\'s NOT a fanny pack!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_1.mdl");
ITEM.ModelColor =       Color(159, 89, 39);
ITEM.Weight =			2;
ITEM.Tier =             1;
ITEM.DefaultStock = 	4;
ITEM.DefaultPrice = 	500;
ITEM.FabricYield =		2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_pouch";
ITEM.StorageSize =      STORAGE_SMALL;
BASH:ProcessItem(ITEM);
