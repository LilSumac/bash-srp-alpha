local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_bizon";
ITEM.Name =             "PP-19 Bizon";
ITEM.Description =      "Deveolped by a team headed by the son of the famous Victor Kalashnikov. This model chambers the 9x18mm Makarov round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/cw2/gsm/w_gsm_bizon.mdl");
ITEM.Tier =             2;
ITEM.Weight =           2;
ITEM.DefaultStock =     12;
ITEM.DefaultPrice =     10000;
ITEM.Durability =       5000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_bizon";
ITEM.AmmoType =         "9x18";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_acog", "md_kobra"}},
    [2] = {header = "Barrel", atts = {"md_tundra9mm"}},
    [3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
