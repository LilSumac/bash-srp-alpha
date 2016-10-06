local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_gsh18";
ITEM.Name =             "GSh-18";
ITEM.Description =      "A small, compact Russian sidearm made up of only 17 parts. Chambers a 9x19mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_pist_gsh1.mdl");
ITEM.Tier =             1;
ITEM.LootHidden =       false;
ITEM.Weight =           0.5;
ITEM.DefaultStock =     20;
ITEM.DefaultPrice =     2000;
ITEM.Durability =       1000;
ITEM.MetalYield =       1;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_gsh18";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}}
};
BASH:ProcessItem(ITEM);
