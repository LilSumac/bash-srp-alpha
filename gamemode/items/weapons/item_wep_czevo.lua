local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_czevo";
ITEM.Name =             "CZ Scorpion Evo 3";
ITEM.Description =      "The third model in CZ's line of small submachine guns, this weapon offers maneuverability and compactness. Chambers a 9x19mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_smg_bf4_cz3a1.mdl");
ITEM.Tier =             3;
ITEM.Weight =           2.75;
ITEM.DefaultStock =     6;
ITEM.DefaultPrice =     15000;
ITEM.Durability =       4000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_czevo";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
