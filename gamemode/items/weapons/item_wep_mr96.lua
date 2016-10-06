local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_mr96";
ITEM.Name =             "MR 96";
ITEM.Description =      "A French revolver chambered with a .357 round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_daxb_bronco.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     7000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_mr96";
ITEM.AmmoType =         "357mag";
ITEM.Attachments = {
    [1] = {header = "Barrel", atts = {"bg_regularbarrel", "bg_longbarrelmr96"}}
};
BASH:ProcessItem(ITEM);
