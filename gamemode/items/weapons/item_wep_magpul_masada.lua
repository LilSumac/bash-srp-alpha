local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_magpul_masada";
ITEM.Name =             "Magpul Masada";
ITEM.Description =      "The next generation carbine planned to replace the M16 for the United States military. Chambers a 5.56x45mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_masada.mdl");
ITEM.Tier =             5;
ITEM.Weight =           4;
ITEM.DefaultStock =     0;
ITEM.DefaultPrice =     68000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_magpul_masada";
ITEM.AmmoType =         "556x45";
ITEM.Attachments = {
    [1] = {header = "Sight", atts = {"md_microt1", "md_cmore", "md_reflex", "md_eotech", "md_aimpoint", "md_elcan"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip", "md_bipod"}},
	[4] = {header = "Rail", atts = {"md_anpeq15"}}
};
BASH:ProcessItem(ITEM);
