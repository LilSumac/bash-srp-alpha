local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_cz75";
ITEM.Name =             "CZ 75";
ITEM.Description =      "A Czech sidearm used by police departments worldwide.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_cz75.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1;
ITEM.DefaultStock =     10;
ITEM.DefaultPrice =     3000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_cz75";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}}
};
BASH:ProcessItem(ITEM);
