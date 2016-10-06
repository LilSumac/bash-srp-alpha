local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m98b";
ITEM.Name =             "Barett M98 Bravo";
ITEM.Description =      "A bolt-action sniper rifle that's designed for magnum rifle cartridges. Chamber a .338 Lapua round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_m82.mdl");
ITEM.Tier =             5;
ITEM.Weight =           6;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     90000;
ITEM.Durability =       1000;
ITEM.MetalYield =       6;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m98b";
ITEM.AmmoType =         "338lapua";
ITEM.Attachments = {
	[1] = {header = "Sight", atts = {"md_eotech", "md_elcan", "md_ballistic", "md_fas2_leupold"}},
	[3] = {header = "Handguard", atts = {"md_bipod"}}
};
BASH:ProcessItem(ITEM);
