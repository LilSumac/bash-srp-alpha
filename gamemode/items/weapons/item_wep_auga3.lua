local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_auga3";
ITEM.Name =             "AUG A3";
ITEM.Description =      "An Austrian bullpup rifle that chambers a standard 5.56 NATO round. This variant has been made more modular than its earlier counterparts.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/cw2/gsm/w_gsm_aug.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3.5;
ITEM.DefaultStock =     3;
ITEM.DefaultPrice =     35000;
ITEM.Durability =       4000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_auga3";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
