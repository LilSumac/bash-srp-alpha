local BASH = BASH;
local ITEM = {};
ITEM.ID =               "wep_an94";
ITEM.Name =             "AN-94";
ITEM.Description =      "A complex, rejected replacement rifle for the AK-74, now used in limited numbers by the Russian Army. Chambers a 5.45x39mm round.";
ITEM.FlavorText =       "";
ITEM.WorldModel =       Model("models/weapons/w_ak107.mdl");
ITEM.Tier =             3;
ITEM.Weight =           4;
ITEM.DefaultStock =     4;
ITEM.DefaultPrice =     38000;
ITEM.Durability =       5000;
ITEM.MetalYield =       4;
ITEM.ItemSize =         SIZE_MED;

ITEM.IsWeapon =         true;
ITEM.SlotType =         "Primary";
ITEM.WeaponEntity =     "bash_wep_an94";
ITEM.AmmoType =         "545x39";
ITEM.Attachments = {
    [1] = {header = "Sight",atts = {"md_microt1", "md_cmore", "md_reflex", "md_elcan", "md_eotech", "md_aimpoint"}},
	[2] = {header = "Barrel", atts = {"md_saker"}},
	[3] = {header = "Handguard", atts = {"md_foregrip"}},
	[4] = {header = "Magazine", atts = {"md_uecw_akmag"}}
};
BASH:ProcessItem(ITEM);
