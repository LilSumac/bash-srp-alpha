local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_hpbrowning";
ITEM.Name =             "Browning Hi-Power";
ITEM.Description =      "One of the most widely-used military pistols in history, chambering a 9mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_hpbr.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1;
ITEM.DefaultStock =     8;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_hpbrowning";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
