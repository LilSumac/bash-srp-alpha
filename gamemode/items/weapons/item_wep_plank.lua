local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_plank";
ITEM.Name =             "Wooden Plank";
ITEM.Description =      "A makeshift weapon made from a wooden plank and some rusty nails.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_plank.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           2;
ITEM.DefaultStock =     30;
ITEM.DefaultPrice =     200;
ITEM.Durability =       200;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Melee";
ITEM.WeaponEntity =     "bash_wep_plank";
BASH:ProcessItem(ITEM);
