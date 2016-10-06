local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_scarh";
ITEM.Name =             "FN SCAR-H";
ITEM.Description =      "An extremely modular Belgian-designed rifle that chambers a larger 7.62x51mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/cw2/rifles/w_scarh.mdl");
ITEM.Tier =             4;
ITEM.Weight =           4;
ITEM.DefaultStock =     1;
ITEM.DefaultPrice =     58000;
ITEM.Durability =       5000;
ITEM.MetalYield =       6;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_scarh";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}},
	[4] = {header = "Handguard", atts = {"md_foregrip", "md_m203"}}
};
BASH:ProcessItem(ITEM);
