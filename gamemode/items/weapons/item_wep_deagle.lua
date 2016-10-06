local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_deagle";
ITEM.Name =             "Desert Eagle";
ITEM.Description =      "An absolute beast of a sidearm. This Israeli-made pistol chambers a .50 Action Express round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_deagle.mdl");
ITEM.Tier =             4;
ITEM.Weight =           1.8;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     42000;
ITEM.Durability =       500;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_deagle";
ITEM.AmmoType =         "50ae";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_acog"}},
    [2] = {header = "Barrel", atts = {"md_saker", "bg_deagle_compensator", "bg_deagle_extendedbarrel"}}
};
BASH:ProcessItem(ITEM);
