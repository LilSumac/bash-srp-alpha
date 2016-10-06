local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_vityaz";
ITEM.Name =             "Vityaz-SN";
ITEM.Description =      "A Russian submachine gun based on the AK-74. Chambers a 9x19mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_smg_ppv.mdl");
ITEM.Tier =             2;
ITEM.Weight =           3;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     12000;
ITEM.Durability =       20000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_vityaz";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_kobra", "md_eotech", "md_aimpoint", "md_pso1", "md_microt1"}},
	[2] = {header = "Barrel", atts = {"md_pbs1"}}
};
BASH:ProcessItem(ITEM);
