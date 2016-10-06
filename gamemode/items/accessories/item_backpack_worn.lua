local BASH = BASH;
local ITEM = {};
ITEM.ID =				"backpack_worn";
ITEM.Name =				"Worn Backpack";
ITEM.Description =		"An old worn backpack with plenty of space for storing collectibles.";
ITEM.FlavorText =		"Yum, yum, yum, yum, yum. Delicioso!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_6.mdl");
ITEM.ModelColor =       Color(159, 89, 39);
ITEM.Tier =             2;
ITEM.Weight =			4;
ITEM.DefaultStock = 	5;
ITEM.DefaultPrice = 	1500;
ITEM.FabricYield =		4;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_backpack";
ITEM.StorageSize =      STORAGE_LARGE;
BASH:ProcessItem(ITEM);
