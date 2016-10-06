local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_mp412";
ITEM.Name =             "MP412 REX";
ITEM.Description =      "A Russian double-action revolver developed for export. Chambers a .357 round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_daxb_bronco.mdl");
ITEM.Tier =             2;
ITEM.Weight =           1;
ITEM.DefaultStock =     6;
ITEM.DefaultPrice =     9000;
ITEM.Durability =       3000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_mp412";
ITEM.AmmoType =         "357mag";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_elcan", "md_docter"}}
};
BASH:ProcessItem(ITEM);
