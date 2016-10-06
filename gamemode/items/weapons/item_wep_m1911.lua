local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m1911";
ITEM.Name =             "M1911";
ITEM.Description =      "The former standard-issue sidearm for the United States military, chambering a .45 ACP round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_hpbr.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1;
ITEM.DefaultStock =     12;
ITEM.DefaultPrice =     7000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_m1911";
ITEM.AmmoType =         "45acp";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_saker"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
