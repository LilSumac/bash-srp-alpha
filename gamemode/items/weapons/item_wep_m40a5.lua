local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m40a5";
ITEM.Name =             "M40A5";
ITEM.Description =      "A bolt-action sniper rifle built from a Remington 700 and used by the United States Marines Corps. Chambers a 7.62x51mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_snip_m40a5.mdl");
ITEM.Tier =             4;
ITEM.Weight =           7.5;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     56000;
ITEM.Durability =       1000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m40a5";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_bipod"}},
	[4] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
