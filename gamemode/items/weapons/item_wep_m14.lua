local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m14";
ITEM.Name =             "M14";
ITEM.Description =      "An extremely modern American carbine, chambered with a 5.56 NATO round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_cstm_m14.mdl");
ITEM.Tier =             4;
ITEM.Weight =           5;
ITEM.DefaultStock =     1;
ITEM.DefaultPrice =     50000;
ITEM.Durability =       5000;
ITEM.MetalYield =       5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m14";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}, dependencies = {md_microt1 = true, md_eotech = true, md_aimpoint = true, md_schmidt_shortdot = true, md_acog = true}}
};
BASH:ProcessItem(ITEM);
