local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ak54";
ITEM.Name =             "AK-54";
ITEM.Description =      "A vintage member of the Kalashnakov family. Chambers a 7.62x54mmR round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_ak54.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           3;
ITEM.DefaultStock =     10;
ITEM.DefaultPrice =     5000;
ITEM.Durability =       3500;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ak54";
ITEM.AmmoType =         "762x54";
BASH:ProcessItem(ITEM);