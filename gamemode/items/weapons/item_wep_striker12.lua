local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_striker12";
ITEM.Name =             "Striker 12";
ITEM.Description =      "A shotgun with a revolving cyliner designed for riot control. Chambers a 12-gauge shell.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_striker_12g.mdl");
ITEM.Tier =             5;
ITEM.Weight =           4.5;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     60000;
ITEM.Durability =       2000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_striker12";
ITEM.AmmoType =         "12x70";
ITEM.Attachments = {
    [1] = {header = "Barrel", atts = {"md_saker"}}
}
BASH:ProcessItem(ITEM);
