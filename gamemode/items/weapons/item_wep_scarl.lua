local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_scarl";
ITEM.Name =             "FN SCAR-L";
ITEM.Description =      "An extremely modular Belgian-designed rifle that chambers a smaller 5.56x45mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_rf_scarl.mdl");
ITEM.Tier =             3;
ITEM.Weight =           3.5;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     38000;
ITEM.Durability =       5000;
ITEM.MetalYield =       5;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_scarl";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Rail", atts = {"md_anpeq15"}},
	[4] = {header = "Handguard", atts = {"md_foregrip"}}
};
BASH:ProcessItem(ITEM);
