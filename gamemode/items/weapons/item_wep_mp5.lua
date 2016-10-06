local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_mp5";
ITEM.Name =             "MP5";
ITEM.Description =      "A 9mm German submachine gun, one of the most widely used in the world.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_smg_mp5.mdl");
ITEM.Tier =             2;
ITEM.Weight =           3;
ITEM.DefaultStock =     12;
ITEM.DefaultPrice =     10000;
ITEM.Durability =       4000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_mp5";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}, exclusions = {bg_mp5_sdbarrel = true}},
    [3] = {header = "Handguard", atts = {"bg_mp5_kbarrel", "bg_mp5_sdbarrel"}},
    [4] = {header = "Magazine", atts = {"bg_mp530rndmag"}},
    [5] = {header = "Stock", atts = {"bg_retractablestock", "bg_nostock"}}
};
BASH:ProcessItem(ITEM);
