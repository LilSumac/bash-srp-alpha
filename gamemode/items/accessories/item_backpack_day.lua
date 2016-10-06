local BASH = BASH;
local ITEM = {};
ITEM.ID =				"backpack_day";
ITEM.Name =				"Daypack";
ITEM.Description =		"A daypack with plenty of space for storing collectibles.";
ITEM.FlavorText =		"Yum, yum, yum, yum, yum. Delicioso!";
ITEM.WorldModel =		Model("models/fallout 3/backpack_6.mdl");
ITEM.Tier =             2;
ITEM.Weight =			4;
ITEM.DefaultStock = 	10;
ITEM.DefaultPrice = 	1500;
ITEM.FabricYield =		4;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsAccessory =		true;
ITEM.Inventory =		"inv_backpack";
ITEM.StorageSize =      STORAGE_LARGE;
BASH:ProcessItem(ITEM);
