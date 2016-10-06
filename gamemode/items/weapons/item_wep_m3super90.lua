local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m3super90";
ITEM.Name =             "M3 Super 90";
ITEM.Description =      "An Italian pump-action shotgun popular with law enforcement around the world.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_cstm_m3super90.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     22000;
ITEM.Durability =       2000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m3super90";
ITEM.AmmoType =         "12x70";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_acog", "md_microt1", "md_eotech", "md_aimpoint"}}
};
BASH:ProcessItem(ITEM);
