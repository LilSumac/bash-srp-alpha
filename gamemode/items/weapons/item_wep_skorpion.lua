local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_skorpion";
ITEM.Name =             "Skorpion vz. 65";
ITEM.Description =      "A Czechoslovak submachine gun developed in 1959. Chambers a 9x18mm Makarov round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/krycek/w_vz61_m9k.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1.25;
ITEM.DefaultStock =     10;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       2000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_skorpion";
ITEM.AmmoType =         "9x18";
ITEM.Attachments = {
    [1] = {header = "Rail", atts = {"md_anpeq15", "kry_vz61_foregrip"}},
    [2] = {header = "Barrel", atts = { "md_tundra9mm"}},
    [3] = {header = "Stock", atts = {"kry_vz61_stock_open"}}
}
BASH:ProcessItem(ITEM);
