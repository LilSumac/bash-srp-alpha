local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_pkm";
ITEM.Name =             "PKM";
ITEM.Description =      "A modernized improved version of the Russian PK machine gun. Chambers a 7.62x54mmR belted round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_mach_m249para.mdl");
ITEM.Tier =             5;
ITEM.Weight =           8;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     100000;
ITEM.Durability =       10000;
ITEM.MetalYield =       8;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_pkm";
ITEM.AmmoType =         "762x54_belt";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_cmore", "md_reflex"}},
	[2] = {header = "Barrel", atts = {"md_pbs1"}},
	[3] = {header = "Handguard", atts = {"md_bipod"}}
};
BASH:ProcessItem(ITEM);
