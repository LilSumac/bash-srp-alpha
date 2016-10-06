local BASH = BASH;
local ITEM = {};
ITEM.ID =				"backpack_molle";
ITEM.Name =				"MOLLE Pack";
ITEM.Description =		"A modular backpack fit for a soldier and their equipment.";
ITEM.FlavorText =		"Yum, yum, yum, yum, yum. Delicioso!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_6.mdl");
ITEM.Tier =             3;
ITEM.LootHidden =       true;
ITEM.Weight =			4;
ITEM.DefaultStock = 	4;
ITEM.DefaultPrice = 	2500;
ITEM.FabricYield =		4;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_backpack_large";
ITEM.StorageSize =      STORAGE_LARGE;
BASH:ProcessItem(ITEM);
