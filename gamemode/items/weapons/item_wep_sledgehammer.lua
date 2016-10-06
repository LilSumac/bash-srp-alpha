local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_sledgehammer";
ITEM.Name =             "Sledgehammer";
ITEM.Description =      "A large sledgehammer fitted with a very heavy headpiece. For construction uses only.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_sledgehammer.mdl");
ITEM.Tier =             1;
ITEM.Weight =           9;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     2000;
ITEM.Durability =       0;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Melee";
ITEM.WeaponEntity =     "bash_wep_sledgehammer";
BASH:ProcessItem(ITEM);
