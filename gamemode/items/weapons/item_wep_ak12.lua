local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ak12";
ITEM.Name =             "AK-12";
ITEM.Description =      "An improved version of the AK-74, and the hopeful future main battle rifle of the Russian Army. Chambers a 5.45x39mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_ak107.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3;
ITEM.DefaultStock =     6;
ITEM.DefaultPrice =     34000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ak12";
ITEM.AmmoType =         "545x39";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker", "md_pbs1"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
