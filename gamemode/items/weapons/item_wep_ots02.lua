local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ots02";
ITEM.Name =             "OTs-02 Kiparis";
ITEM.Description =      "A Russian submachine gun introduced into service in 1991. Chambers a 9x18mm Makarov round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/krycek/w_vz61_m9k.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1.5;
ITEM.DefaultStock =     18;
ITEM.DefaultPrice =     8000;
ITEM.Durability =       2000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_ots02";
ITEM.AmmoType =         "9x18";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
