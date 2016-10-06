local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_glock17";
ITEM.Name =             "Glock 17";
ITEM.Description =      "A semi-automatic Austrian sidearm used by militaries and civilians worldwide.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_piso_dzembi1.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_glock17";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
