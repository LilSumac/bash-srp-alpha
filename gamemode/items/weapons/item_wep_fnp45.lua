local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_fnp45";
ITEM.Name =             "FN FNP-45";
ITEM.Description =      "A Belgian sidearm manufactured in the USA chambered with a .45 ACP round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_co45.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     7000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_fnp45";
ITEM.AmmoType =         "45acp";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
