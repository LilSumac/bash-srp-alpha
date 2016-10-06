local BASH = BASH;
local ITEM = {};
ITEM.ID =				"satchel_black";
ITEM.Name =				"Black Satchel";
ITEM.Description =		"A medium-sized black satchel that can hold a few belongings.";
ITEM.FlavorText =		"Plus, it's not a man-purse, it's a satchel.";
ITEM.WorldModel =		Model("models/fallout 3/backpack_2.mdl");
ITEM.Weight =			3;
ITEM.Tier =             1;
ITEM.LootHidden =       true;
ITEM.DefaultStock = 	15;
ITEM.DefaultPrice = 	1000;
ITEM.FabricYield =		3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_satchel";
ITEM.StorageSize =      STORAGE_MED;
BASH:ProcessItem(ITEM);
