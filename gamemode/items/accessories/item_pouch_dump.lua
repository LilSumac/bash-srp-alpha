local BASH = BASH;
local ITEM = {};
ITEM.ID =				"pouch_dump";
ITEM.Name =				"Dump Pouch";
ITEM.Description =		"A tactical pouch that soldiers dump empty magazines into.";
ITEM.FlavorText =		"RELOADING!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_1.mdl");
ITEM.Weight =			2;
ITEM.Tier =             1;
ITEM.LootHidden =       true;
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	500;
ITEM.FabricYield =		2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_pouch";
ITEM.StorageSize =      STORAGE_SMALL;
BASH:ProcessItem(ITEM);
