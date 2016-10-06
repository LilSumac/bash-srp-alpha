local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_glock18";
ITEM.Name =             "Glock 18";
ITEM.Description =      "A semi-automatic Austrian sidearm used by militaries and civilians worldwide. Features a fully-automatic firemode";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_piso_dzembi1.mdl");
ITEM.Tier =             4;
ITEM.Weight =           1;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     40000;
ITEM.Durability =       5000;
ITEM.MetalYield =       2;
ITEM.ItemSize =         SIZE_SMALL;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Secondary";
ITEM.WeaponEntity =     "bash_wep_glock18";
ITEM.AmmoType =         "9x19";
ITEM.Attachments = {
	[1] = {header = "Sight", atts = {"md_microt1", "md_kobra"}},
	[2] = {header = "Rail", atts = {"md_anpeq15"}},
	[3] = {header = "Barrel", atts = {"md_tundra9mm"}}
};
BASH:ProcessItem(ITEM);
