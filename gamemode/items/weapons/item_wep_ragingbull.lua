local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_ragingbull";
ITEM.Name =             "Taurus Raging Bull";
ITEM.Description =      "A large, iconic revolver, marketed as a hunter's sidearm. Chambered with a .44 Magnum round";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_daxb_bronco.mdl");
ITEM.Tier =             4;
ITEM.Weight =           2;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     41000;
ITEM.Durability =       500;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_ragingbull";
ITEM.AmmoType =         "44mag";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_rmr", "md_acog"}}
};
BASH:ProcessItem(ITEM);
