local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_awm";
ITEM.Name =             "AWM";
ITEM.Description =      "A bolt-action sniper rifle that's designed for magnum rifle cartridges. Chamber a .338 Lapua round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_awm.mdl");
ITEM.Tier =             5;
ITEM.Weight =           7;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     75000;
ITEM.Durability =       1000;
ITEM.MetalYield =       8;
ITEM.ItemSize =         SIZE_LARGE;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_awm";
ITEM.AmmoType =         "338lapua";
ITEM.Attachments = {
	{header = "Sight", atts = {"md_microt1", "md_cmore", "md_reflex", "md_elcan", "md_eotech", "md_aimpoint", "md_acog", "md_ballistic", "md_fas2_leupold"}},
	{header = "Barrel", atts = {"md_saker"}},
	{header = "Handguard", atts = {"md_bipod"}},
	{header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
