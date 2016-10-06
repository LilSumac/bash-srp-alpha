local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_g3a3";
ITEM.Name =             "G3A3";
ITEM.Description =      "A German battle rifle used throughout Europe that chambers a 7.62x51mm NATO round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_snip_g3sg1.mdl");
ITEM.Tier =             3;
ITEM.Weight =           4;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     33000;
ITEM.Durability =       4000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_g3a3";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "bg_sg1scope"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_m203", "bg_bipod"}}
};
BASH:ProcessItem(ITEM);
