local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m9";
ITEM.Name =             "Beretta M9";
ITEM.Description =      "The current standard-issue sidearm for the United States military, chambering a 9mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_cz75.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_m9";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
