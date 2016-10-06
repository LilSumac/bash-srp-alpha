local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m4a1";
ITEM.Name =             "M4A1";
ITEM.Description =      "A shorter and lighter variant of the M16 series used by the United States Army and Marines Corps. Chambers a 5.56x45mm round.";
ITEM.FlavorText =       "This is my rifle. There are many like it, but this one is mine.";
ITEM.WorldModel =       Model("models/weapons/w_rif_m4a1.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     23000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m4a1";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_uecw_foldsight", "md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_bipod"}},
	[4] = {header = "Magazine", atts = {"md_uecw_60rnd"}}
};
BASH:ProcessItem(ITEM);
