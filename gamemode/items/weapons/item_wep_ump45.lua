local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ump45";
ITEM.Name =             "UMP45";
ITEM.Description =      "A 9mm German submachine gun, adopted by many government agencies around the world.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_smg_ump45.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     24000;
ITEM.Durability =       30000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ump45";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
