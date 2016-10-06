local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_sr25";
ITEM.Name =             "SR-25";
ITEM.Description =      "A semi-automatic sniper rifle with up to 60% of its parts interchangable with an AR-15 or M16. Chambers a 7.62x51mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/mk11/w_snipr_mk11.mdl");
ITEM.Tier =             5;
ITEM.Weight =           4.5;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     72000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_sr25";
ITEM.AmmoType =         "762x51";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_schmidt_shortdot"}},
    [2] = {header = "Barrel", atts = {"md_saker"}},
    [3] = {header = "Handguard", atts = {"md_foregrip", "md_m203"}},
    [4] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
