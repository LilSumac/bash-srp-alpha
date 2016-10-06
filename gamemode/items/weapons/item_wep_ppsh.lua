local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ppsh";
ITEM.Name =             "PPSh-41";
ITEM.Description =      "A Soviet submachine gun that saw extensive use in World War II. Chambers a 7.62x25mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/pps/w_smg_pps.mdl");
ITEM.Tier =             1;
ITEM.Weight =           4;
ITEM.DefaultStock =     12;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       2000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ppsh";
ITEM.AmmoType =         "762x25";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_kobra", "md_aimpoint", "md_acog"}},
    [2] = {header = "Barrel", atts = {"md_saker"}},
    [3] = {header = "Handguard", atts = {"md_foregrip", "md_bipod"}},
    [4] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
