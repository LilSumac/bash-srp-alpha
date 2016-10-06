local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m249";
ITEM.Name =             "M246";
ITEM.Description =      "An American adaptation of the FN Minimi used by their armed forces. Chambers a 5.56x45mm belted round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_lemg_m249dzem.mdl");
ITEM.Tier =             5;
ITEM.Weight =           10;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     110000;
ITEM.Durability =       10000;
ITEM.MetalYield =       8;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m249";
ITEM.AmmoType =         "556x45_belt";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_eotech", "md_acog", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_hk416_bipod"}}
};
BASH:ProcessItem(ITEM);
