local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ak74";
ITEM.Name =             "AK-74";
ITEM.Description =      "The grandson of the centerpiece of Russian weaponry, the AK-47. Used throughout former Soviet states and the rest of the world. Chambers a 5.45x39mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_rif_ak47.mdl");
ITEM.Tier =             2;
ITEM.Weight =           3;
ITEM.DefaultStock =     20;
ITEM.DefaultPrice =     18000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ak74";
ITEM.AmmoType =         "545x39";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_pso1"}},
	[2] = {header = "Barrel", atts = {"md_pbs1"}},
	[3] = {header = "Receiver", atts = {"bg_ak74_rpkbarrel", "bg_ak74_ubarrel"}},
	[4] = {header = "Handguard", atts = {"md_foregrip"}, exclusions = {bg_ak74_rpkbarrel = true}},
    [5] = {header = "Magazine", atts = {"bg_ak74rpkmag"}},
	[6] = {header = "Stock", atts = {"bg_ak74foldablestock", "bg_ak74heavystock"}}
};
BASH:ProcessItem(ITEM);
