local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_saiga12k";
ITEM.Name =             "Saiga 12K";
ITEM.Description =      "A Russian shotgun patterend after the Kalashnikov family of rifles. Chambers a 12-gauge shell.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_cw20_saiga2.mdl");
ITEM.Tier =             4;
ITEM.Weight =           3.5;
ITEM.DefaultStock =     2;
ITEM.DefaultPrice =     52000;
ITEM.Durability =       4000;
ITEM.MetalYield =       3;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_saiga12k";
ITEM.AmmoType =         "12x70";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_kobra", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
