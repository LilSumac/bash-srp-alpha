local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_hk45";
ITEM.Name =             "HK45 Compact";
ITEM.Description =      "A German-made .45 caliber pistol made for American military use.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_co45.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     5;
ITEM.DefaultPrice =     8000;
ITEM.Durability =       4000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_hk45";
ITEM.AmmoType =         "45acp";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
