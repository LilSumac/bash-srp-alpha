local BASH = BASH;
local ITEM = {};
ITEM.ID =				"backpack_black";
ITEM.Name =				"Black Backpack";
ITEM.Description =		"A rugged black backpack with plenty of space for storing collectibles.";
ITEM.FlavorText =		"Yum, yum, yum, yum, yum. Delicioso!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_6.mdl");
ITEM.Weight =			4;
ITEM.Tier =             2;
ITEM.LootHidden =       true;
ITEM.DefaultStock = 	15;
ITEM.DefaultPrice = 	1500;
ITEM.FabricYield =		4;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_backpack";
ITEM.StorageSize =      STORAGE_LARGE;
BASH:ProcessItem(ITEM);
