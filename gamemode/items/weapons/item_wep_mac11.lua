local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_mac11";
ITEM.Name =             "MAC-11";
ITEM.Description =      "An American-designed subcompact machine pistol. Chambers a 9x19mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_cst_mac11.mdl");
ITEM.Tier =             1;
ITEM.Weight =           1.5;
ITEM.DefaultStock =     10;
ITEM.DefaultPrice =     6000;
ITEM.Durability =       2000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_mac11";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_eotech"}},
	[2] = {header = "Barrel", atts = {"md_tundra9mm"}},
	[3] = {header = "Barrel ext", atts = {"bg_mac11_extended_barrel"}},
	[4] = {header = "Stock", atts = {"bg_mac11_unfolded_stock"}}
};
ITEM.IncludedAttachments = {
    ["Stock"] = "bg_mac11_unfolded_stock"
};
BASH:ProcessItem(ITEM);
