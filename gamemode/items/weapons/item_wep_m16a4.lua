local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m16a4";
ITEM.Name =             "M16A4";
ITEM.Description =      "An American carbine that can take on a number of shapes and forms. The landmark rifle known and used throughout many NATO counties.";
ITEM.FlavorText =       "This is my rifle. There are many like it, but this one is mine.";
ITEM.WorldModel =       Model("models/weapons/w_m16.mdl");
ITEM.Tier =             2;
ITEM.Weight =           4;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     22000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m16a4";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_uecw_foldsight", "md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_bipod", "md_m203"}},
	[4] = {header = "Magazine", atts = {"md_uecw_60rnd"}},
	[5] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
