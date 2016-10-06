local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_shovel";
ITEM.Name =             "Shovel";
ITEM.Description =      "A metal shovel for digging holes and skulls.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_shovel.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           3;
ITEM.DefaultStock =     20;
ITEM.DefaultPrice =     500;
ITEM.Durability =       200;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Melee";
ITEM.WeaponEntity =     "bash_wep_shovel";
BASH:ProcessItem(ITEM);
