local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_tt30";
ITEM.Name =             "TT-30";
ITEM.Description =      "A small, compact Russian sidearm that was the predecessor to the Makarov. Chambers a 7.62x25mm Tokarev round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_tokevpist.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           0.8;
ITEM.DefaultStock =     18;
ITEM.DefaultPrice =     1000;
ITEM.Durability =       15000;
ITEM.MetalYield =       1;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_tt30";
ITEM.AmmoType =         "762x25";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
