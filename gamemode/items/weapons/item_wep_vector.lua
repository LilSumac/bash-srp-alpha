local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_vector";
ITEM.Name =             "KRISS Vector";
ITEM.Description =      "An unconventional submachine gun designed in the US. Chambers a .45 ACP round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_acp_crb.mdl");
ITEM.Tier =             5;
ITEM.Weight =           3;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     62000;
ITEM.Durability =       30000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_vector";
ITEM.AmmoType =         "45acp";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
