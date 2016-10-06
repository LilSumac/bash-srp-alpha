local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_tar21";
ITEM.Name =             "TAR-21";
ITEM.Description =      "An Israeli bullpup assault rifle known for its reliability. Chambers a 5.56x45mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_rif_tar21.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3.25;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     30000;
ITEM.Durability =       30000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_tar21";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
