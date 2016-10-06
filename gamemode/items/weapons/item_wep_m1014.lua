local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_m1014";
ITEM.Name =             "M1014";
ITEM.Description =      "The latest semi-automatic installment in Benelli's line of M-series shotguns. Chambers a 12-gauge shell.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_m1014.mdl");
ITEM.Tier =             4;
ITEM.Weight =           4;
ITEM.DefaultStock =     1
ITEM.DefaultPrice =     54000;
ITEM.Durability =       2000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_m1014";
ITEM.AmmoType =         "12x70";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_eotech", "md_aimpoint", "md_acog"}},
	[2] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
