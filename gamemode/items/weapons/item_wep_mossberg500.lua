local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_mossberg500";
ITEM.Name =             "Mossberg 500";
ITEM.Description =      "A pump-action shotgun that is the number one selling shotgun to date. Chambers a 12-gauge shell.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_m500.mdl");
ITEM.Tier =             2;
ITEM.Weight =           3;
ITEM.DefaultStock =     18;
ITEM.DefaultPrice =     18000;
ITEM.Durability =       2000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_mossberg500";
ITEM.AmmoType =         "12x70";
ITEM.Attachments = {
    [1] = {header = "Barrel", atts = {"md_saker"}}
};
BASH:ProcessItem(ITEM);
