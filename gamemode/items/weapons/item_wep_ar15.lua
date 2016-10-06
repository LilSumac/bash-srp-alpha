local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ar15";
ITEM.Name =             "AR-15";
ITEM.Description =      "An American carbine that can take on a number of shapes and forms. The landmark rifle known and used throughout many NATO counties.";
ITEM.FlavorText =       "This is my rifle. There are many like it, but this one is mine.";
ITEM.WorldModel =       Model("models/weapons/w_rif_m4a1.mdl");
ITEM.Tier =             3;
ITEM.Weight =           4;
ITEM.DefaultStock =     8;
ITEM.DefaultPrice =     25000;
ITEM.Durability =       5000;
ITEM.MetalYield =       5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ar15";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"bg_foldsight", "md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Receiver", atts = {"bg_magpulhandguard", "bg_longbarrel", "bg_ris", "bg_longris"}},
	[4] = {header = "Handguard", atts = {"md_foregrip", "md_m203"}},
    [5] = {header = "Magazine", atts = {"bg_ar1560rndmag"}},
	[6] = {header = "Stock", atts = {"bg_ar15sturdystock", "bg_ar15heavystock"}},
	[7] = {header = "Rail", atts = {"md_anpeq15"}, dependencies = {bg_ris = true, bg_longris = true}}
};
BASH:ProcessItem(ITEM);
