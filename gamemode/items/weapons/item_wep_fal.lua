local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_fal";
ITEM.Name =             "FN FAL";
ITEM.Description =      "One of the most widely used rifles in history, used in over 90 different countries. This French battle rifle chambers a 7.62x51mm NATO round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_fnfal.mdl");
ITEM.Tier =             3;
ITEM.Weight =           5;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     31000;
ITEM.Durability =       4000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_fal";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan", "md_ballistic"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
