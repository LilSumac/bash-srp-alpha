local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m16a2";
ITEM.Name =             "M16A2";
ITEM.Description =      "An American carbine that can take on a number of shapes and forms. The landmark rifle known and used throughout many NATO counties.";
ITEM.FlavorText =       "This is my rifle. There are many like it, but this one is mine.";
ITEM.WorldModel =       Model("models/weapons/w_m16.mdl");
ITEM.Tier =             3;
ITEM.Weight =           4;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     20000;
ITEM.Durability =       5000;
ITEM.MetalYield =       6;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m16a2";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_reflex", "md_eotech", "md_aimpoint", "md_elcan"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_bipod"}}
};
BASH:ProcessItem(ITEM);
