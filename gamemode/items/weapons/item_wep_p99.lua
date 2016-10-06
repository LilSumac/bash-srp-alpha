local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_p99";
ITEM.Name =             "P99";
ITEM.Description =      "A small, compact German sidearm produced for law enforcement and sport shooting alike. Chambers a 9x19mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_p99a.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           0.5;
ITEM.DefaultStock =     10;
ITEM.DefaultPrice =     4000;
ITEM.Durability =       3000;
ITEM.MetalYield =       1;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_p99";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
